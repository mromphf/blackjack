require_relative "../../lib/player.rb"
require_relative "../../lib/card.rb"

Given(/^I am a player$/) do
  @player = Player.new
end

When(/^the dealer deals me a (\d+) of hearts$/) do |value|
  @player = @player.add_card(Card.new(value.to_i, :hearts))
end

When(/^the dealer deals me a (\d+) of clubs$/) do |value|
  @player = @player.add_card(Card.new(value.to_i, :clubs))
end

When(/^the dealer deals me a (\d+) of spades$/) do |value|
  @player = @player.add_card(Card.new(value.to_i, :spades))
end

When(/^the dealer deals me a (\d+) of diamonds$/) do |value|
  @player = @player.add_card(Card.new(value.to_i, :diamonds))
end

When(/^the dealer deals me a jack of clubs$/) do 
  @player = @player.add_card(Card.new(11, :clubs))
end

When(/^the dealer deals me a queen of clubs$/) do 
  @player = @player.add_card(Card.new(12, :clubs))
end

When(/^the dealer deals me a king of clubs$/) do 
  @player = @player.add_card(Card.new(13, :clubs))
end

When(/^the dealer deals me a king of hearts$/) do 
  @player = @player.add_card(Card.new(13, :hearts))
end

When(/^the dealer deals me a jack of hearts$/) do 
  @player = @player.add_card(Card.new(11, :hearts))
end

When(/^the dealer deals me a king of diamonds$/) do 
  @player = @player.add_card(Card.new(13, :diamonds))
end

When(/^the dealer deals me an ace of hearts$/) do 
  @player = @player.add_card(Card.new(1, :hearts))
end

When(/^the dealer deals me an ace of spades$/) do 
  @player = @player.add_card(Card.new(1, :spades))
end

Then(/^I should have a total score of (\d+)$/) do |value|
  expect(@player.score).to eq value.to_i
end

Then(/^I should have blackjack$/) do
  expect(@player.blackjack?)
end

Then(/^I should bust$/) do
  expect(@player.bust?)
end
