require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "using data directly (maybe used for some reports)" do
    order = OrderRepository::OrderData.create! amount: 10, deliver_at: Date.today
    order.items.create! amount: 6, name: 'Item 1'
    order.items.create! amount: 4, name: 'Item 2'

    assert_equal 2, order.reload.items.size
    assert_equal 6, order.items.first.amount
  end

  test "using a model" do
    order_data = OrderRepository::OrderData.create! amount: 10, deliver_at: Date.today

    order = Order.new(order_data)
    order.amount = 15

    assert_equal 15, order.amount
  end

  test "creating a new model" do
    order = Order.new
    order.amount = 15

    assert_equal 15, order.amount
  end

  test "using hash to initialize a model" do
    order = Order.new amount: 15
    assert_equal 15, order.amount
  end

  test "using an aggregate with children" do
    order_data = OrderRepository::OrderData.create! amount: 10, deliver_at: Date.today
    order_data.items.create! amount: 6, name: 'Item 1'

    order = Order.new order_data
    assert_equal 6, order.items.first.amount
  end

  test "using a repository to select models" do
    OrderRepository::OrderData.create! amount: 10, deliver_at: Date.today
    orders = OrderRepository.find_by_amount 10
    assert_equal 10, orders.first.amount
  end

  test "persisting models" do
    order = Order.new
    order.amount = 10

    OrderRepository.persist order

    assert order.id.present?
    assert_equal 10, order.amount
  end

  test "persisting an aggregate with children" do
    order = Order.new
    order.amount = 10
    order.add_item name: 'item1', amount: 5

    OrderRepository.persist order

    from_db = OrderRepository.find(order.id)
    assert_equal 5, from_db.items.first.amount
  end

  test "using data structure instead of a data object (can be used for testing)" do
    order = Order.new OpenStruct.new
    order.amount = 99
    assert_equal 99, order.amount
  end
end