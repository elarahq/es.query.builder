class RangeAggregationBuilder

  include ::ValuesSourceAggregationHelper
  include ::AbstractAggregationHelper
  include ::AbstractRangeHelper
  include ::AggregationQueryBuilderHelper


  def initialize name
    @name = name.to_sym
    @type = :range
    @query = {
      @name => {
        @type => {}
      }
    }
  end
  
end