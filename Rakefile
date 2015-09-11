require 'squib'
$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/src"
require 'spider_monkey_version'

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

task :badge do
  build_number = '%03d' % SpiderMonkey::VERSION
  require 'erb'
  svg = ERB.new(File.read('src/build-badge.svg.erb')).result(binding)
  File.open('build-badge.svg', 'w+') { |f| f.write(svg) }
end