class Order
  include Model

  fields :id, :amount
  collections :items

  def add_item attrs
    collection(:items).new attrs
  end
end