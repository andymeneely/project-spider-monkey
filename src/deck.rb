require 'pp'
require 'squib'
require 'game_icons'
require_relative 'squib_helpers'
require_relative 'version'
require_relative 'refinements'
require_relative 'svg_effects'
require_relative 'build_groups'
using Squib::Refinements

mode = ENV['pallete'] # bw or color
case mode
when 'color'
  fg = '#28221b' # dark
  # fg = '#cfcfcf' # blueprint white
  bg = '#FFDCAA' # light tan
  # bg = '#DDD2C3' # light gray
  # bg = '#002bb1' # blueprint blue

  pallete = {
    'Wood' => '#553200',
    'Steel' => '#133453',
    'Stone' => '#474747',
    'Gold' => '#807015',
    'Art' => '#303030',
    'Food'     => '#303030',
    'Shelter'  => '#303030',
    'Clothing' => '#303030',
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
id = data['Name'].index_lookups

Squib::Deck.new(cards: data['Name'].size, layout: 'layout.yml') do
  background color: bg

  enable_group :bw if mode == 'bw'
  enable_group :color if mode == 'color'
  # enable_group :sheets
  # enable_group :test_cases
  enable_group :singles
  enable_group :hands
  enable_group :showcase
  enable_group :pdfs
  # enable_group :proof

  group :bw do
    load_bw_art_icons data['GameIcon']
    svg layout: 'art', file: data['GameIcon'].map { |art| "bw/art_#{art}.svg" }
  end

  group :color do
    svg layout: 'art', data: data['GameIcon'].map { |gi| SvgEffects.drawing(gi) }
  end

  text str: data['Name'], layout: 'name', color: fg

  %w(Wood Steel Stone Gold).each do |res|
    rect range: data[res].each.with_index.map { |x, i| x.nil? ? nil : i }.compact,
         layout: "#{res.downcase}_rect",
         fill_color: pallete[res], stroke_width: 0
    text str: data[res], layout: "#{res.downcase}_amt", color: bg
    icons = data[res].map { |amt| "#{mode}/resource_#{res.downcase}.svg" unless amt.nil? }
    svg file: icons, layout: "#{res.downcase}_icon"
  end

  svg layout: :vp
  text str: data['VP'], layout: 'vp', color: bg

  text(str: data['Description'], layout: :bonus_text) do |embed|
    %w(Wood Steel Stone Gold).each do |res|
      embed.svg key: res, file: "img/#{mode}/resource_embed_#{res.downcase}.svg", dy: -5, width: 52, height: :scale
    end
  end

  text str: data['AtEnd'], layout: :at_game_end, color: bg

  # rect range: data['Description'].non_nil_indices, layout: :bonus
  # rect range: data['Description'].non_nil_indices, layout: :bonus_icon

  text str: data['Snark'], layout: 'snark', alpha: 0.75

  group(:proof) { png file: 'tgc-proof-overlay.png' }

  group :singles do
    save prefix: "card_#{mode}_#{version}_", format: :png
  end

  group :test_cases do
    save_png prefix: "card_#{mode}_#{version}_", range: id['Obelisk']
    save_png prefix: "card_#{mode}_#{version}_", range: id['Robot Golem']
    save_png prefix: "card_#{mode}_#{version}_", range: id['Battle Axe']
    save_png prefix: "card_#{mode}_#{version}_", range: id['Spear']
    save_png prefix: "card_#{mode}_#{version}_", range: id['Anvil']
  end

  # save_png

  save_plaintext data, file: "data/deck.txt"

  group :showcase do
    showcase range: [id['Robot Golem'], id['Battle Axe']], fill_color: :black, trim: 37.5
  end

  rect layout: 'cut_line'

  group :pdfs do
    save_pdf dir: "builds", file: "deck_#{mode}_#{version}.pdf", trim: 37.5
  end

  group :changed do
    save_sheet range: whats_changed, prefix: 'whats_changed_'
  end

  group :hands do
    rect layout: 'outline'
    20.times do |i|
      random_5 = (0..size-1).to_a.sample(5).sort
      hand range: random_5, trim: 37.5, trim_radius: 25, file: "hand_#{mode}_#{'%02d' % i}.png"
    end
  end

end

puts "Done!"
