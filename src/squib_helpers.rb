require 'game_icons'
require 'json'
require_relative 'version'

def version
  SpiderMonkey::VERSION
end

# Generates a JSON output from deck for easy Git tracking.
def save_plaintext(data, file_txt: 'data/deck.txt', file_json: 'data/deck.json')
  File.open(file_txt,"w+") { |f| f.write(data.to_pretty_text) }
  File.open(file_json,"w+") { |f| f.write(data.to_json) }
end

# Return the range of cards that changed since the given commit
def whats_changed(since: 'playtested', exclude: 'Qty', dump: 'data/deck.json')
  old = JSON.parse `git show #{since}:#{dump}`
  cur = JSON.parse File.read(dump)
  change = []
  cur.each do |id, card|
    have_it, i = compare_to_old(card, old: old, exclude: exclude)
    old.reject! { |k, v| k == i }
  end
  return changed
end

def compare_to_old(card, old: {}, exclude: 'Qty')
  old.each do |i, old_card|
  end
end

# Explode quantity field
def explode_quantities(raw_deck)
  qtys = raw_deck['Qty']
  deck = {}
  raw_deck.each do |col, arr|
    deck[col] = []
    qtys.each_with_index do |qty, index|
      qty.to_i.times{ deck[col] << arr[index] }
    end
  end
  return deck
end

def prep_game_icons(game_icons, fg, bg)
  cache = {}
  game_icons.each do |name|
    cache[name] ||= GameIcons.get(name).recolor(fg: fg, bg: bg).string
  end
  cache
end

def load_bw_art_icons(game_icons)
  game_icons.each do |icon|
    unless File.exist? "img/bw/art_#{icon}.svg"
      File.open("img/bw/art_#{icon}.svg", 'w+') do |f|
        f.write(GameIcons.get(icon).recolor(fg: '#000', bg: '#fff').string)
      end
    end
  end
end
