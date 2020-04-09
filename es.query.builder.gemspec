Gem::Specification.new do |s|
  s.name        = 'es_query_builder'
  s.version     = '2.0.4'
  s.summary     = 'For Building Elastic Search Queries'
  s.authors     = ['Mohib Yousuf', 'Anurag Agrawal', 'Supantha Samanta', 'Neeraj Joshi']
  s.email       = ['mohib.yousuf@hotmail.com', 'anuragagrawal117@gmail.com', 'supantha.samanta@gmail.com', 'neerajjoshi00@gmail.com']
  s.files       = Dir["lib/**/*.rb"]
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/elarahq/es.query.builder'
  s.add_runtime_dependency 'rails', '~> 4.0', '>= 4.0.2'
  s.add_runtime_dependency 'elasticsearch'
  s.add_runtime_dependency 'activesupport'
  s.add_development_dependency "rspec", '3.5.0'
end