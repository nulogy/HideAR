class Order
  include Model

  fields :id, :amount

  def items
    _data.items.map{|_| Item.new _}
  end

  def add_item attrs
    _data.items.new attrs
  end
end