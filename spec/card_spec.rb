require_relative "../lib/card.rb"

describe Card do
  let(:card) { Card.new(2, :hearts) }

  describe "constructor" do
    it "takes in a suit and a value" do
      expect(card).to be_a Card
    end

    it "will throw an exception if given a value greater than thirteen" do
      expect { Card.new(14, :diamonds) }.to raise_error "ERROR: A card cannot be assigned a value of 14."
    end

    it "will throw an exception if given an invalid suit" do
      expect { Card.new(3, :foo) }.to raise_error "ERROR: Cannot create a card with suit: foo."
    end
  end

  describe "equality" do
    it "is true when the values and the suits of the card are the same" do
      expect(Card.new(7, :hearts)).to eq Card.new(7, :hearts) 
    end

    describe "is not true" do
      it "when values are the same but the suits are different" do
        expect(Card.new(8, :hearts)).not_to eq Card.new(8, :clubs) 
      end

      it "when the suits are the same but the values are different" do
        expect(Card.new(11, :hearts)).not_to eq Card.new(13, :hearts) 
      end

      it "when both the values and the suits are different" do
        expect(Card.new(8, :spades)).not_to eq Card.new(13, :hearts) 
      end
    end
  end

  describe "sorting" do
    it "can be done by value" do
      unsorted_cards = [Card.new(11, :hearts), Card.new(3, :hearts), Card.new(7, :hearts)]
      sorted_cards = [Card.new(3, :hearts), Card.new(7, :hearts), Card.new(11, :hearts)]
      expect(unsorted_cards.sort_by { |c| c.value } ).to eq sorted_cards
    end
  end 

  describe "aces" do
    it "is an ace if it has a value of one" do
      expect(Card.new(1, :hearts).ace?).to be_truthy
    end

    it "is not an ace if has a value greater than one" do
      expect(Card.new(2, :spades).ace?).to be_falsy
    end
  end

  describe "to-string" do
    describe "on non-face cards" do
      it "provides the correct output on spades" do
        expect(Card.new(8, :spades).to_s).to eq "8 of Spades"
      end

      it "provides the correct output on hearts" do
        expect(Card.new(3, :hearts).to_s).to eq "3 of Hearts"
      end
    end

    describe "on face cards" do
      it "provides the correct output on clubs" do
        expect(Card.new(11, :clubs).to_s).to eq "Jack of Clubs"
      end

      it "provides the correct output on diamonds" do
        expect(Card.new(13, :diamonds).to_s).to eq "King of Diamonds"
      end
    end

    describe "on aces" do
      it "provides the expected string for clubs" do
        expect(Card.new(1, :clubs).to_s).to eq "Ace of Clubs"
      end

      it "provides the expected string for diamonds" do
        expect(Card.new(1, :diamonds).to_s).to eq "Ace of Diamonds"
      end
    end
  end

  describe "render" do
    it "will provide the corresponding image name for spades" do
      expect(Card.new(6, :spades).render).to eq "spades06.png"
    end

    it "will provide the corresponding image name for hearts" do
      expect(Card.new(9, :hearts).render).to eq "hearts09.png"
    end

    it "will provide the corresponding image name for clubs" do
      expect(Card.new(11, :clubs).render).to eq "clubs11.png"
    end

    it "will provide the corresponding image name for diamonds" do
      expect(Card.new(13, :diamonds).render).to eq "diamonds13.png"
    end

    it "will provide the corresponding image name for ace of spades" do
      expect(Card.new(1, :spades).render).to eq 'spades01.png'
    end

    it "will provide the corresponding image name for ace of diamonds" do
      expect(Card.new(1, :diamonds).render).to eq 'diamonds01.png'
    end
  end

  it "is a face card if its face is greater than 10" do
    expect(Card.new(12, :clubs).face?).to be_truthy
  end

  it "is not a face card if it is an ace" do
    expect(Card.new(1, :diamonds).face?).to be_falsy
  end
end
