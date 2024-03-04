class VendingMachine::Slot
  attr_reader :id, :product_name, :product_count, :product_cost

  def initialize(id, product_name, product_count, product_cost)
    @id = id
    @product_name = product_name
    @product_count = product_count
    @product_cost = product_cost
  end

  def out_of_stock?
    product_count == 0
  end

  def reduce_product_count
    @product_count -= 1
  end
end
