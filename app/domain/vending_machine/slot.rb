class VendingMachine::Slot
  attr_reader :id, :product_name, :product_count, :product_cost

  def initialize(id, product_name, product_count, product_cost)
    @id = id
    @product_name = product_name
    @product_count = product_count
    @product_cost = product_cost
  end
end
