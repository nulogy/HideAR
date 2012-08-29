module OrderRepository
  extend Repository

  class OrderData < ActiveRecord::Base
    self.table_name = "orders"

    attr_accessible :amount, :deliver_at

    validates :amount, numericality: true
    has_many :items, class_name: 'OrderRepository::ItemData', foreign_key: 'order_id'
  end

  class ItemData < ActiveRecord::Base
    self.table_name = "items"

    attr_accessible :amount, :name

    validates :amount, numericality: true
    validates :name, presence: true
  end

  set_data_class OrderData
  set_model_class Order


  def self.find_by_amount amount
    where(amount: amount)
  end
end