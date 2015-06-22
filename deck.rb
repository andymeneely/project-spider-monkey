require 'pp'
require 'squib'
require 'game_icons'
require_relative 'squib_helpers'

fg = '#000' #black
bg = '#fff' #white

deck = Squib.xlsx file: 'data/deck.xlsx'
deck = explode_quantities(deck)

game_icon_cache = prep_game_icons(deck['GameIcon'], fg, bg)
names_to_game_icons = {
  'Wood'  => 'planks',
  'Steel' => 'nails',
  'Stone' => 'stone-block',
  'Gold'  => 'gold-bar'
}

Squib::Deck.new(cards: deck['Name'].size, layout: 'layout.yml',) do
  background color: :white
  svg layout: 'vp', file: 'vp.svg'

  %w(Name Snark VP).each do |field|
    text str: deck[field], layout: field.downcase
  end

  %w(Wood Steel Stone Gold).each do |field|
    text str: deck[field], layout: "#{field.downcase}_amt"
    icons = (deck[field].collect { |name| game_icon_cache[names_to_game_icons[field]] unless name.nil? })
    svg data: icons, layout: "#{field.downcase}_icon"
  end

  text(str: deck['Description'], layout: 'description') do |embed|
    embed.svg key: 'Wood', data: game_icon_cache['planks']
    embed.svg key: 'Steel', data: game_icon_cache['nails']
    embed.svg key: 'Stone', data: game_icon_cache['stone-block']
    embed.svg key: 'Gold', data: game_icon_cache['gold-bar']
  end

  svg layout: 'art', data: (deck['GameIcon'].collect { |name| game_icon_cache[name] })

  # png file: 'tgc-proof-overlay.png'
  save format: :png
  save_json cards: @cards.size, deck: deck, file: "data/deck.json"
  rect layout: 'cut_line'
  hand range: (40..45), trim: 37.5
  save_pdf file: 'deck.pdf', trim: 37.5
end
