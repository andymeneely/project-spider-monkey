require 'squib'
$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/src"
require 'spider_monkey_version'

desc 'Build black-and-white only'
task default: [:bw]

desc 'Build both bw and color'
task all: [:bw, :color]

desc 'Build black-and-white only'
task :bw do
  puts "=== Building black and white deck ==="
  ENV['pallete'] = 'bw'
  load 'src/deck.rb'
end

desc 'Build the color version only'
task color: :recolor do
  puts "=== Building color deck ==="
  ENV['pallete'] = 'color'
  load 'src/deck.rb'
end

desc 'Recolor the SVG icons for color build'
task :recolor do
  load 'src/recolor_icons.rb'
end

desc 'Rebuild the badge SVG for the version number'
task :badge do
  build_number = '%03d' % SpiderMonkey::VERSION
  require 'erb'
  svg = ERB.new(File.read('src/build-badge.svg.erb')).result(binding)
  File.open('build-badge.svg', 'w+') { |f| f.write(svg) }
end
