class Order
  include Model

  set_data_class OrderRepository::OrderData

  fields :id, :amount

  def items
    internal_data.items.map{|_|Item.new _}
  end

  def add_item attrs
    internal_data.items.new attrs
  end
end