require 'squib'

task default: [:bw]

task :bw do
  ENV['pallete'] = 'bw'
  Rake::Task["deck"].invoke
end

task :color do
  ENV['pallete'] = 'color'
  Rake::Task["deck"].invoke
end

task :deck do
  load 'deck.rb'
end
