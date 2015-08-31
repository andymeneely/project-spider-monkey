require 'pp'
require 'squib'
require 'game_icons'
require_relative 'squib_helpers'

fg = '#000' #black
bg = '#fff' #white

# fg = '#552C00'
# bg = '#FFD6AA'

# fg = '#003333'
# bg = '#D46A6A'

deck = Squib.xlsx file: 'data/deck.xlsx'
deck = explode_quantities(deck)

game_icon_cache = prep_game_icons(deck['GameIcon'], fg, bg)
names_to_game_icons = {
  'Wood'  => 'log',
  'Steel' => 'nails',
  'Stone' => 'stone-block',
  'Gold'  => 'gold-bar'
}

id = {}
deck['Name'].each_with_index{ |name,i| id[name] = i}

Squib::Deck.new(cards: deck['Name'].size, layout: 'layout.yml',) do
  background color: bg

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
    embed.svg key: 'Wood', data: game_icon_cache['log'], dy: -5, width: 52, height: :scale
    embed.svg key: 'Steel', data: game_icon_cache['nails'], dy: -5, width: 52, height: :scale
    embed.svg key: 'Stone', data: game_icon_cache['stone-block'], dy: -5, width: 52, height: :scale
    embed.svg key: 'Gold', data: game_icon_cache['gold-bar'], dy: -5, width: 52, height: :scale
  end

  with_desc = deck['Description'].each.with_index.map { |x, i| x.nil? ? nil : i }.compact
  rect range: with_desc, layout: 'description'

  svg layout: 'art', data: (deck['GameIcon'].collect { |name| game_icon_cache[name] })

  # png file: 'overlay.png', blend: 'overlay', alpha: 0.5
  # png file: 'tgc-proof-overlay.png'

  # save format: :png
  save_json cards: @cards.size, deck: deck, file: "data/deck.json"

  rect layout: 'cut_line'
  save_pdf file: 'deck.pdf', trim: 37.5
  save_sheet range: whats_changed, prefix: 'whats_changed_'

  # rect layout: 'outline'
  # hand range: (40..45), trim: 37.5, trim_radius: 25
  # save_sheet prefix: 'sheet_'



  # save_png range: id['Ancient Pyramid']
end
