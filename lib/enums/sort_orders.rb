 module Enums 
  class SortOrders

    SORT_ORDERS = {:asc => :asc, :desc => :desc}

    attr_reader :sort_order

    SORT_ORDERS.each do |sort_order, es_value|
      define_singleton_method(sort_order) do
        return self.new(es_value)
      end
    end

    def initialize sort_order
      @sort_order = sort_order
    end

  end
end