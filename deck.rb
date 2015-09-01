require 'pp'
require 'squib'
require 'game_icons'
require_relative 'squib_helpers'


case ENV['use_color']
when 'color'
  fg = '#000'
  bg = '#FFF3AA'

  pallete = {
    'Wood' => '#553200',
    'Steel' => '#333',
    'Stone' => '#333',
    'Gold' => :black,
    'Art' => :black,
    'Food'     => :black,
    'Shelter'  => :black,
    'Clothing' => :black,
  }
when 'bw'
  fg = '#000' #black
  bg = '#fff' #white

  pallete = {
    'Wood' => :black,
    'Steel' => :black,
    'Stone' => :black,
    'Gold' => :black,
    'Art' => :black,
    'Food'     => :black,
    'Shelter'  => :black,
    'Clothing' => :black,
  }
end


data = Squib.xlsx file: 'data/deck.xlsx'
data = explode_quantities(data)

game_icon_cache = prep_game_icons(data['GameIcon'] + %w(wheat house shorts), bg, fg)
names_to_game_icons = {
  'Wood'     => 'log',
  'Steel'    => 'nails',
  'Stone'    => 'stone-block',
  'Gold'     => 'gold-bar',
  'food'     => 'wheat',
  'shelter'  => 'house',
  'clothing' => 'shorts',
}

id = data['Name'].each.with_index.inject({}) { | hsh, (name, i)| hsh[name] = i; hsh}

Squib::Deck.new(cards: data['Name'].size, layout: 'layout.yml',) do
  background color: bg

  %w(Name Snark).each do |field|
    text str: data[field], layout: field.downcase
  end

  %w(Wood Steel Stone Gold).each do |field|
    rect range: data[field].each.with_index.map { |x, i| x.nil? ? nil : i }.compact, layout: "#{field.downcase}_rect", fill_color: pallete['Art']
    text str: data[field], layout: "#{field.downcase}_amt", color: bg
    icons = (data[field].collect { |name| game_icon_cache[names_to_game_icons[field]] unless name.nil? })
    svg data: icons, layout: "#{field.downcase}_icon"
  end

  rect layout: 'vp_frame', fill_color: fg
  %w(food shelter clothing).each do |field|
    icons = data['VPtype'].map { |name| game_icon_cache[names_to_game_icons[name]]}
    svg data: icons, layout: "#{field.downcase}_icon"
  end
  text str: data['VP'], layout: 'vp', color: bg

  text(str: data['Description'], layout: 'description') do |embed|
    embed.svg key: 'Wood', data: game_icon_cache['log'], dy: -5, width: 52, height: :scale
    embed.svg key: 'Steel', data: game_icon_cache['nails'], dy: -5, width: 52, height: :scale
    embed.svg key: 'Stone', data: game_icon_cache['stone-block'], dy: -5, width: 52, height: :scale
    embed.svg key: 'Gold', data: game_icon_cache['gold-bar'], dy: -5, width: 52, height: :scale
  end

  with_desc = data['Description'].each.with_index.map { |x, i| x.nil? ? nil : i }.compact
  rect range: with_desc, layout: 'description'

  rect layout: 'art_frame', fill_color: pallete['Art']
  svg layout: 'art', data: (data['GameIcon'].collect { |name| game_icon_cache[name] })

  # png file: 'tgc-proof-overlay.png'

  save format: :png
  # save_png range: id['Obelisk']

  save_json cards: @cards.size, deck: data, file: "data/deck.json"

  rect layout: 'cut_line'
  save_pdf file: 'deck.pdf', trim: 37.5
  # save_sheet range: whats_changed, prefix: 'whats_changed_'

  rect layout: 'outline'
  20.times do |i|
    hand range: (0..size-1).to_a.sample(5).sort, trim: 37.5, trim_radius: 25, file: "hand_#{'%02d' % i}.png"
  end

  save_sheet prefix: 'sheet_'

end
