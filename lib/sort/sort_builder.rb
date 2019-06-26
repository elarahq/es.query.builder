class SortBuilder
  include AttributesReader

  def initialize
    @order = nil
  end

  def common_query
    query = {}
    query[:order] = @order if @order.present?
    return query
  end

# returns order
  def order_expr
    return @order
  end
# sets order
  def order sort_order
    @order = sort_order.sort_order
    return self
  end

end