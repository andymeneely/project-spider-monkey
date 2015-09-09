require 'squib'

task default: [:bw]

task :bw do
  ENV['pallete'] = 'bw'
  Rake::Task["deck"].invoke
end

task color: :recolor do
  ENV['pallete'] = 'color'
  Rake::Task["deck"].invoke
end

task :deck do
  load 'deck.rb'
end

task :recolor do
  load 'recolor_icons.rb'
end