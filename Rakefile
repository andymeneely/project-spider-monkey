require 'squib'
$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/src"

task default: [:bw]

task all: [:bw, :color]

task :bw do
  puts "=== Building black and white deck ==="
  ENV['pallete'] = 'bw'
  load 'src/deck.rb'
end

task color: :recolor do
  puts "=== Building color deck ==="
  ENV['pallete'] = 'color'
  load 'src/deck.rb'
end

task :recolor do
  load 'src/recolor_icons.rb'
end