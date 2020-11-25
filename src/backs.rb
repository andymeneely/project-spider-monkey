require 'pp'
require 'squib'
require 'game_icons'
require_relative 'squib_helpers'
require_relative 'version'
require_relative 'refinements'
using Squib::Refinements

data = Squib.xlsx file: 'data/deck.xlsx'

Squib::Deck.new(cards: data.nrows) do
  use_layout file: 'layouts/backs.yml'
  background color: :white

  text str: data.name, layout: :name
  svg file: data.stage.dot_svg('stage_'), layout: :stage

  save_png prefix: 'back_'
  save_sheet prefix: 'sheet_backs_', columns: 5, rows: 5

end

puts "Done!"
