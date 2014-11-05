Gem::Specification.new do |s|
  s.name        = 'chrome_store_search'
  s.version     = '0.0.9'
  s.date        = '2014-11-05'
  s.summary     = "chrome web store search"
  s.description = "chrome web store apps, extensions and themes search"
  s.authors     = ["Grant Chen"]
  s.email       = 'kucss@hotmail.com'

  s.add_runtime_dependency 'json',   '~> 1.8', '>= 1.8.1'
  s.add_runtime_dependency 'faraday', '~> 0.8', '>= 0.8.8'
  s.add_runtime_dependency 'nokogiri', '~> 1.6', '>= 1.6.4'

  s.files         = Dir['lib/**/*.rb'] + Dir['*.rb']
  s.homepage    =
    'https://github.com/grantchen/chrome_store_search'
  s.license       = 'MIT'
end
