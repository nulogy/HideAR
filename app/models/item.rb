class Item
  include Model

  set_data_class OrderRepository::ItemData

  fields :id, :amount
end