class DateRangeAggregationBuilder

  include ::ValuesSourceAggregationHelper
  include ::AbstractAggregationHelper
  include ::AbstractRangeHelper
  include ::AggregationQueryBuilderHelper


  def initialize name
    @name = name.to_sym
    @type = :date_range
    @query = {
      @name => {
        @type => {}
      }
    }
  end
  
end