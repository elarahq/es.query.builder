# require 'elastic_search_query'
# require 'token_query_builder'
# require 'fetch_es_data'
# require 'indexer'
# require 'constants'
require 'active_support/all'
require_relative 'attributes_reader'
Dir[File.join(__dir__, 'enums', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'common', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'function_scores', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'queries', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'scripts', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'aggregations', 'helpers', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'aggregations', 'buckets', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'aggregations', 'metrics', '*.rb')].each { |file| require file }
require_relative 'query_builders'
require_relative 'enum_builders'
Dir[File.join(__dir__, 'aggregation_builders.rb')].each { |file| require file }

module EsQueryBuilder
end