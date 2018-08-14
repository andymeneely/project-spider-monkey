require 'squib'
require 'rake/clean'

require_relative 'src/squib_helpers'
require_relative 'src/version'

# Add Rake's clean & clobber tasks
CLEAN.include('_output/*').exclude('_output/gitkeep.txt')

desc 'Build black-and-white only'
task default: [:bw]

desc 'Build both bw and color'
task all: [:with_pdf, :bw, :color]

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

desc 'Enable PDF build'
task :with_pdf do
  Squib.enable_build_globally :pdfs
end


desc 'Build the rules PDF'
task rules: ['rules:md_to_html','rules:html_to_pdf']

namespace :rules do
  task :md_to_html do
    load 'src/rules.rb' # convert markdown
    # Embed into HTML CSS
    erb = ERB.new(File.read('docs/RULES_TEMPLATE.html.erb'))
    File.open('docs/RULES.html', 'w+') do |html|
      html.write(erb.result)
    end
  end

  task html_to_pdf: [:md_to_html] do
    sh <<-EOS.gsub(/\n/, '')
      wkhtmltopdf
      --page-width    3.5in
      --page-height   5.0in
      --margin-left   0.15in
      --margin-right  0.15in
      --margin-bottom 0.15in
      --margin-top    0.15in
        docs/RULES.html _output/RULES.pdf
    EOS
  end
end
