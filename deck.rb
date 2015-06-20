require 'pp'
require 'squib'
require 'game_icons'
require_relative 'squib_helpers'

deck = Squib.xlsx file: 'data/deck.xlsx'
pp deck
deck = explode_quantities(deck)

game_icon_cache = prep_game_icons(deck['GameIcon'])
names_to_game_icons = {
  'Wood'  => 'planks',
  'Steel' => 'nails',
  'Stone' => 'stone-block',
  'Gold'  => 'gold-bar'
}

Squib::Deck.new(cards: deck['Name'].size, layout: 'layout.yml',) do

  svg layout: 'vp', file: 'vp.svg'

  %w(Name Snark VP Cost1Amt Cost2Amt).each do |field|
    text str: deck[field], layout: field.downcase
  end

  text(str: deck['Description'], layout: 'description') do |embed|
    embed.svg key: 'Wood', data: game_icon_cache['planks']
    embed.svg key: 'Steel', data: game_icon_cache['nails']
    embed.svg key: 'Stone', data: game_icon_cache['stone-block']
    embed.svg key: 'Gold', data: game_icon_cache['gold-bar']
  end

  svg layout: 'art', data: (deck['GameIcon'].collect { |name| game_icon_cache[name] })

  %w(Cost1Type Cost2Type).each do |icon|
    svg layout: icon.downcase, data: deck[icon].collect { |name| game_icon_cache[names_to_game_icons[name]] }
  end

  png file: 'tgc-proof-overlay.png'
  save format: :png
  save_json cards: @cards.size, deck: deck, file: "data/deck.json"
end
