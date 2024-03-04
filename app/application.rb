class Application
  def run
    init_vending_machine
    run_interactions
  end

  private

  def init_vending_machine
    vending_machine = VendingMachine.new

    vending_machine.add_slot(VendingMachine::Slot.new(1, "Snickers", 4, 10))
    vending_machine.add_slot(VendingMachine::Slot.new(2, "Cola", 5, 15.5))
    vending_machine.add_slot(VendingMachine::Slot.new(3, "M&M's", 1, 5))

    Store[:vending_machine] = vending_machine
  end

  def run_interactions
    Interactions.run(
      Interactions::ShowVendingMachineSlots,
      Interactions::AskForCoins,
      Interactions::AskForProduct
    )
  end
end
