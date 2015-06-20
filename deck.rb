require 'pp'
require 'squib'
require 'game_icons'
require_relative 'squib_helpers'

deck = Squib.xlsx file: 'data/deck.xlsx'
pp deck
deck = explode_quantities(deck)

game_icon_cache = prep_game_icons(deck['GameIcon'])

Squib::Deck.new(cards: deck['Name'].size, layout: 'layout.yml',) do

  %w(Name Snark).each do |field|
    text str: deck[field], layout: field.downcase
  end

  text(str: deck['Description'], layout: 'description') do |embed|
    embed.svg key: 'Wood', data: game_icon_cache['planks']
    embed.svg key: 'Steel', data: game_icon_cache['nails']
    embed.svg key: 'Stone', data: game_icon_cache['stone-block']
    embed.svg key: 'Gold', data: game_icon_cache['gold-bar']
  end


  svg layout: 'art', data: (deck['GameIcon'].collect { |name| game_icon_cache[name] })

  png file: 'tgc-proof-overlay.png'
  save format: :png
end
