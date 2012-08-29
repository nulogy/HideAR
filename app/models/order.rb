class Order
  include Model

  fields :id, :amount

  def items
    wrap(_data.items)
  end

  def add_item attrs
    _data.items.new attrs
  end
end