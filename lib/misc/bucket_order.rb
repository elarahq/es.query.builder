module Misc
  class BucketOrder
    include AttributesReader

    # @param [String|Symbol] field
    # @param [Enums::SortOrders] order : Enums::SortOrders.(desc|asc), defaults to Enums::SortOrders.desc
    def initialize field:, order: Enums::SortOrders.desc
      @field = field.intern
      @order = order.sort_order
    end

    # return [Hash]
    def settings
      {@field => @order}
    end

    # @return [String]
    def field_expr
      @field
    end

    # @return [Enums::SortOrders]
    def order_expr
      @order
    end

  end
end