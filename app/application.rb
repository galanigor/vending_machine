class Application
  def run
    init_vending_machine
    run_interactions
  end

  private

  def init_vending_machine
    vending_machine = VendingMachine.new

    vending_machine.add_slot(id: 1, product_name: "Snickers", product_count: 4, product_cost: 10)
    vending_machine.add_slot(id: 2, product_name: "Cola", product_count: 5, product_cost: 15.5)
    vending_machine.add_slot(id: 3, product_name: "M&M's", product_count: 0, product_cost: 5)
    vending_machine.add_slot(id: 4, product_name: "Orbit", product_count: 2, product_cost: 2.25)

    Store[:vending_machine] = vending_machine
  end

  def run_interactions
    Interactions.run(Interactions::GetProduct)
  end
end
