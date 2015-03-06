Feature: Scores
    In order to beat the dealer and win chips
    As a player
    I want to be dealt cards to accumulate a score

    Scenario: Add three cards to form a score
        Given I am a player
        When the dealer deals me a 5 of hearts
        And the dealer deals me a 10 of clubs
        And the dealer deals me a 2 of spades
        Then I should have a total score of 17

    Scenario: Add two cards to form blackjack
        Given I am a player
        When the dealer deals me a Jack of clubs
        And the dealer deals me a 1 of spades
        Then I should have blackjack

    Scenario: Add two face cards for a score of twenty
        Given I am a player
        When the dealer deals me a King of diamonds
        And the dealer deals me a Queen of clubs
        Then I should have a total score of 20

    Scenario: Bust
        Given I am a player
        When the dealer deals me a King of hearts
        And the dealer deals me a 10 of diamonds
        And the dealer deals me a 5 of clubs
        Then I should bust

    Scenario: Aces low
        Given I am a player
        When the dealer deals me a 1 of hearts
        And the dealer deals me a 5 of clubs
        Then I should have a total score of 6

    @wip
    Scenario: Aces high
        Given I am a player
        When the dealer deals me a 1 of diamonds
        And the dealer deals me a Jack of clubs 
        Then I should have a total score of 21
