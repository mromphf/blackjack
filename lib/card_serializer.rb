class CardSerializer
  STRING_SUITS = { "Spades" => :spades, "Hearts" => :hearts, "Clubs" => :clubs, "Diamonds" => :diamonds }

  def self.deserialize(data)
    cards = []
    data.each do |item|
      elements = item.split
      value = elements[0].reverse.chomp('"').reverse.to_i
      suit = STRING_SUITS[elements[2].chomp('"')]
      cards << self.build_card(value, suit)
    end
    cards
  end

  def self.serialize(cards)
    cards.map(&:serialize)
  end

  private
    def self.build_card(value, suit)
      Card.new(value, suit)
    end
end
