class GeoGridAggregationBuilder

  include ::ValuesSourceAggregationHelper
  include ::AbstractAggregationHelper
  include ::AggregationQueryBuilderHelper

  ATTRIBUTES = [:size, :precision]

  def initialize name
    @name = name.to_sym
    @type = :geohash_grid
    @query = {
      @name => {
        @type => {}
      }
    }
  end

  def size size
    @size = size
    self
  end

  def get_size
    @size
  end

  def precision precision
    @precision = precision
    self
  end

  def get_precision
    @precision
  end

  # def query
  #   @query[@name][:geohash_grid].merge!(value_source_agg_builder)
  #   ATTRIBUTES.each do |attr|
  #     attr_inst = instance_variable_get("@#{attr.to_s}")
  #     @query[@name][:geohash_grid][attr] = attr_inst if attr_inst.present?
  #   end
  #   @query[@name].merge!(abstract_agg_builder)
  #   @query
  # end

  
end