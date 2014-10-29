require_relative 'boot'

desc "CSS for URL"
task :css4url do
  url = ENV.fetch('URL')
  cfm = ColorsFromImage.new(image: url)
  puts cfm.to_css
end
