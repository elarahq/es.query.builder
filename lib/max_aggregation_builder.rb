class MaxAggregationBuilder

  include ::ValuesSourceAggregationHelper
  include ::AbstractAggregationHelper
  include ::AggregationQueryBuilderHelper

  def initialize name
    @name = name.to_sym
    @type = :max
    @query = {
      @name => {
        @type => {}
      }
    }
  end
  
end