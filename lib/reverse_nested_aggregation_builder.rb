class ReverseNestedAggregationBuilder

  include ::AbstractAggregationHelper
  include ::AggregationQueryBuilderHelper

  def initialize name
    @name = name.to_sym
    @type = :reverse_nested
    @query = {
      @name => {
        @type => {}
      }
    }
  end
  
end
