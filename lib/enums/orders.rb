class Orders

  ORDERS = {desc: 'desc', asc: 'asc'}

  attr_reader :order

  ORDERS.keys.each do |order|
    define_singleton_method(order) do
      return self.new(ORDERS[order])
    end
  end

  def initialize value
    @order = value
  end
  
end