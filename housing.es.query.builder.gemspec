Gem::Specification.new do |s|
  s.name        = 'housing.es.query.builder'
  s.version     = '1.0.0'
  s.summary     = 'For Building Elastic Search Queries'
  s.authors     = ['Mohib Yousuf']
  s.email       = 'mohib.yousuf@hotmail.com'
  s.files       = Dir["lib/*"]
  s.license     = 'MIT'
  s.homepage    = ''
  s.add_runtime_dependency 'rails', '~> 4.0', '>= 4.0.2'
  s.add_runtime_dependency 'elasticsearch', '~> 5.0'
end