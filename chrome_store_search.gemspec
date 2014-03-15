Gem::Specification.new do |s|
  s.name        = 'chrome_store_search'
  s.version     = '0.0.1'
  s.date        = '2014-03-12'
  s.summary     = "chrome web stroe search"
  s.description = "chrome web stroe apps, extensions and themes search"
  s.authors     = ["Grant Chen"]
  s.email       = 'kucss@hotmail.com'

  s.add_dependency('json','>= 1.8.1')

  s.files         = Dir['lib/**/*.rb'] + Dir['*.rb']
  s.homepage    =
    'https://github.com/grantchen/chrome_store_search'
end
