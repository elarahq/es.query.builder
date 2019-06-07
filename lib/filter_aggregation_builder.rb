class FilterAggregationBuilder

  include ::AbstractAggregationHelper
  include ::AggregationQueryBuilderHelper

  def initialize name, filter
    @name = name.to_sym
    @type = :filter
    @filter = filter
    @query = {
      @name => {
        @type => @filter
      }
    }
  end

  def get_filter
    @filter
  end
  
end