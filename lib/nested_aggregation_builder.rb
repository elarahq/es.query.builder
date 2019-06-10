class NestedAggregationBuilder

  include ::AbstractAggregationHelper
  include ::AggregationQueryBuilderHelper

  def initialize name, path
    @name = name.to_sym
    @type = :nested
    @path = path
    @query = {
      @name => {
        @type => {
          :path => path
        }
      }
    }
  end

  def get_path
    @path
  end

  
end