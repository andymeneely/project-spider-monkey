require 'squib'
require 'game_icons'
require_relative 'squib_helpers'

data = Squib.xlsx file: 'data/deck.xlsx'
data = explode_quantities(data)

light = "#FFDCAA" #light yellow-ish
dark  = "#28221b" #dark grayish

res_map = {
  'wood'     => ['log',         '#553200'],
  'steel'    => ['nails',       '#133453'],
  'stone'    => ['stone-block', '#474747'],
  'gold'     => ['gold-bar',    '#807015'],
}

vp_map = {
  'food'     => ['wheat',  dark],
  'shelter'  => ['house',  dark],
  'clothing' => ['shorts', dark],
}

res_map.each do |res, (gi, color)|
  File.open("img/color/resource_#{res}.svg", 'w+')       { |f| f.write(GameIcons.get(gi).recolor(fg: light, bg: color).string) }
  File.open("img/color/resource_embed_#{res}.svg", 'w+') { |f| f.write(GameIcons.get(gi).recolor(fg: color, bg: light).string) }
end

vp_map.each do |vp, (gi, color)|
  File.open("img/color/vp_#{vp}.svg", 'w+')       { |f| f.write(GameIcons.get(gi).recolor(fg: light, bg: color).string) }
end

puts "Recoloring done!"
