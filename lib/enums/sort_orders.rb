# frozen_string_literal: true

module Enums
  # Enumerator class for sort ordering
  class SortOrders
    # @!visibility protected
    SORT_ORDERS = { asc: 'asc', desc: 'desc' }.freeze
    # @!visibility protected
    attr_reader :sort_order

    # @!visibility protected
    SORT_ORDERS.each do |sort_order, es_value|
      define_singleton_method(sort_order) do
        return new(es_value)
      end
    end

    # @!scope class
    # @!method asc
    # @return [SortOrders] SortOrders object
    #   corresponding to elasticsearch option of 'asc'

    # @!scope class
    # @!method desc
    # @return [SortOrders] SortOrders object
    #   corresponding to elasticsearch option of 'desc'

    # @!visibility protected
    def initialize(sort_order)
      @sort_order = sort_order
    end
  end
end
