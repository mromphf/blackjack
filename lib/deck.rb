class Deck
  NUMBER_OF_NON_ACE_CARDS = 12
  SUITS = [:spades, :hearts, :clubs, :diamonds]

  def initialize
    @cards = []
    SUITS.each { |suit| add_suit_to_deck(suit) }
  end

  def deal_card(drawn_cards=[])
    drawn_cards.each { |card| @cards.delete(card) }
    random_index = (Random.rand(1..@cards.size) - 1)
    @cards[random_index]
  end

  private
    def add_suit_to_deck(suit)
      @cards << Ace.new(suit)
      NUMBER_OF_NON_ACE_CARDS.times do |i|
        @cards << Card.new(i + 2, suit)
      end
    end
end
