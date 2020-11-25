require 'pp'
require 'squib'
require 'game_icons'
require_relative 'squib_helpers'
require_relative 'version'
require_relative 'refinements'
require_relative 'svg_effects'
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
n = data.nrows
save_plaintext data

Squib::Deck.new(cards: n) do
  use_layout file: 'layouts/deck.yml'
  background color: bg

  build :bw do
    load_bw_art_icons data['GameIcon']
    svg layout: 'art',
        file: data['GameIcon'].map { |art| "bw/art_#{art}.svg" }
  end

  build :color do
    svg layout: 'art',
        data: data['GameIcon'].map { |gi| SvgEffects.drawing(gi) }
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
  svg layout: :stage, file: data.stage.map { |s| "stage_#{s}.svg"}

  rect layout: :bonus,
       stroke_width: 5, stroke_color: :black, radius: 20,
       range: (0..n-1).reject { |i| data.description[i].to_s.empty? }
  svg layout: :bonus_type,
      file: data['TypeDesc'].map { |t| "#{t}.svg" unless t.nil? }

  text(str: data['Description'], layout: :bonus_text) do |embed|
    %w(Wood Steel Stone Gold).each do |res|
      embed.svg key: res, file: "img/#{mode}/resource_embed_#{res.downcase}.svg", dy: -5, width: 52, height: :scale
    end
  end

  text str: data['AtEnd'], layout: :at_game_end, color: bg

  text str: data['Snark'], layout: 'snark'

  build(:proof) { png file: 'tgc-proof-overlay.png' }

  save prefix: "card_", format: :png
  save_sheet prefix: 'sheet_deck_', columns: 5, rows: 5
  cut_zone
  save_pdf file: 'diecut_fronts.pdf'

  build :showcase do
    showcase range: [id['Robot Golem'], id['Battle Axe']], fill_color: :black, trim: 37.5
  end

  rect layout: 'cut_line'

  build :pdfs do
    save_pdf dir: "builds", file: "deck_#{mode}_#{version}.pdf", trim: 37.5
  end

  build :changed do
    save_sheet range: whats_changed, prefix: 'whats_changed_'
  end

  build :hands do
    rect layout: 'outline'
    20.times do |i|
      random_5 = (0..size-1).to_a.sample(5).sort
      hand range: random_5, trim: 37.5, trim_radius: 25, file: "hand_#{mode}_#{'%02d' % i}.png"
    end
  end

end

puts "Done!"
