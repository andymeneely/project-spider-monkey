require 'pp'
require 'squib'
require 'game_icons'
require 'squib_helpers'

mode = ENV['pallete'] # bw or color
case mode
when 'color'
  fg = '#28221b' # dark
  bg = '#FFDCAA' # light

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
data = explode_quantities(data)

id = data['Name'].each.with_index.inject({}) { | hsh, (name, i)| hsh[name] = i; hsh}

Squib::Deck.new(cards: data['Name'].size, layout: 'layout.yml',) do
  background color: bg

  # Illustration on the bottom
  case mode
  when 'bw'
    load_bw_art_icons data['GameIcon']
    svg layout: 'art', file: data['GameIcon'].map { |art| "#{mode}/art_#{art}.svg" }
  when 'color'
    files = data['GameIcon'].map do |a|
      f = "color/art_#{a}.png"
      File.exist?("img/#{f}") ? f : nil
    end
    png file: files, blend: 'hard_light', alpha: 0.65
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

  rect layout: 'vp_frame', fill_color: fg
  %w(food shelter clothing).each do |field|
    icons = data['VPtype'].map { |name| "#{mode}/vp_#{name}.svg" }
    svg file: icons, layout: "#{field.downcase}_icon"
  end
  text str: data['VP'], layout: 'vp', color: bg

  text(str: data['Description'], layout: 'description') do |embed|
    %w(Wood Steel Stone Gold).each do |res|
      embed.svg key: res, file: "img/#{mode}/resource_embed_#{res.downcase}.svg", dy: -5, width: 52, height: :scale
    end
  end

  with_desc = data['Description'].each.with_index.map { |x, i| x.nil? ? nil : i }.compact
  rect range: with_desc, layout: 'description'

  text str: data['Snark'], layout: 'snark', alpha: 0.75

  # png file: 'tgc-proof-overlay.png'

  save prefix: "card_#{mode}_#{build}_", format: :png
  # save_png prefix: "card_#{mode}_", range: id['Obelisk']
  # save_png prefix: "card_#{mode}_", range: id['Robot Golem']

  save_json cards: @cards.size, deck: data, file: "data/deck.json"

  showcase range: [id['Robot Golem'], id['Battle Axe']], fill_color: :black, trim: 37.5

  rect layout: 'cut_line'
  save_pdf dir: "builds", file: "deck_#{mode}_#{build}.pdf", trim: 37.5
  # save_sheet range: whats_changed, prefix: 'whats_changed_'

  # rect layout: 'outline'
  # 20.times do |i|
  #   hand range: (0..size-1).to_a.sample(5).sort, trim: 37.5, trim_radius: 25, file: "hand_#{mode}_#{'%02d' % i}.png"
  # end

end
