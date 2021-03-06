class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def first_name
    self.name.split(' ')[0]
  end

  def place_bet!(bet)
    if can_afford? bet
      self.bet = bet
      self.money -= bet
      self.money = 0 if self.money < 0
      self.in_game = true
      save!
      return { json: {} }
    else
      return { nothing: true }
    end
  end

  def double_down!
    self.money -= bet
    self.bet += bet
    save!
  end

  def win!
    self.money += (self.bet * 2)
    self.in_game = false
    save!
  end

  def push!
    self.money += self.bet
    self.in_game = false
    save!
  end

  def lose!
    self.in_game = false
    save!
  end

  def reset_money!
    self.money = 200
    save!
  end

  def is_broke?
    self.money <= 0 
  end

  private
    def can_afford?(bet)
      self.money >= bet
    end
end
