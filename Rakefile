require 'squib'

task default: [:bw]

task all: [:bw, :color]

task :bw do
  puts "=== Building black and white deck ==="
  ENV['pallete'] = 'bw'
  load 'deck.rb'
end

task color: :recolor do
  puts "=== Building color deck ==="
  ENV['pallete'] = 'color'
  load 'deck.rb'
end

task :recolor do
  load 'recolor_icons.rb'
end