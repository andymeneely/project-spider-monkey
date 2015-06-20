require 'pp'
require 'squib'
require_relative 'squib_helpers'

deck = Squib.xlsx file: 'data/deck.xlsx'
pp deck
deck = explode_quantities(deck)

Squib::Deck.new(cards: deck['Name'].size, layout: 'layout.yml',) do
  
  %w(Name).each do |key|
    text str: deck[key], layout: key.downcase
  end

  png file: 'tgc-proof-overlay.png'
  save format: :png
end
