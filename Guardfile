group :everything do
  guard 'rake', :task => 'all' do
    watch %r{.*\.xlsx$}
    watch %r{.*\.rb$}
    watch %r{.*\.yml}
  end
end

group :docs do
  guard 'rake', :task => 'rules' do
    watch %r{.*\.xlsx$}
    watch %r{.*\.rb$}
    watch %r{.*\.yml$}
    watch %r{.*\.md$}
    watch %r{.*\.css$}
  end
end
