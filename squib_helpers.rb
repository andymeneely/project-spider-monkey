require 'game_icons'
require 'json'

# Generates a JSON output from deck for easy Git tracking.
def save_json(cards: 1, deck: {}, file: 'deck.json')
  h = {}
  (0..cards-1).each do |i|
    h[i] ||= {}
    deck.each_pair do |key, value|
      h[i][key] = value[i]
    end
  end
  File.open(file,"w") do |f|
    f.write(JSON.pretty_generate(h))
  end
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
