class PlayerWins
  def execute(user, bet)
    user.win!(bet)
  end
end

class PlayerLoses
  def execute(user, bet)
    user.lose!(bet)
  end
end

class PlayerPush
  def execute(user, bet)
  end
end
