class TopHitsAggregationBuilder

  include ::AbstractAggregationHelper
  include ::AggregationQueryBuilderHelper

  ATTRIBUTES = [:size, :sort, :_source]

  def initialize name
    @name = name.to_sym
    @type = :top_hits
    @query = {
      @name => {
        @type => {}
      }
    }
    @sort = []
    @_source = {}
  end

  def size size
    @size = size
    self
  end

  def get_size
    @size
  end

  def add_sort field, order=:desc
    @sort << {field => { order: order}}
    self
  end

  def script_sort script, type=:number, order=:desc
    @sort = {
      :_script => {
          :type => type,
          :script => {
            :source => script
          },
          :order => order
      }
    }
    self
  end

  def get_sort
    @sort
  end

  def source include_list, exclude_list=[]
    @_source[:include] = include_list if include_list.present?
    @_source[:exclude] = exclude_list if exclude_list.present?
    self
  end

  def get_source
    @_source
  end
  
end