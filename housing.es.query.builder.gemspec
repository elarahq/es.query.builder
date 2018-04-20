Gem::Specification.new do |s|
  s.name        = 'housing.es.query.builder'
  s.version     = '1.0.0'
  s.summary     = "For Building Elastic Search Queries"
  s.authors     = ["Mohib Yousuf"]
  s.email       = 'mohib.yousuf@proptiger.com'
  s.files       = Dir["lib/*"]
  s.add_dependency "rails", ">= 4.0.2"
  s.add_dependency "elasticsearch"	
end