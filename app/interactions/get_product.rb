class Interactions::GetProduct < Interactions::Base
  def run
    vending_machine.reset_inputs

    Interactions.run(
      Interactions::ShowVendingMachineSlots,
      Interactions::AskForCoins,
      Interactions::AskForProduct,
      Interactions::EjectProduct,
      Interactions::GiveChange,
      Interactions::MaybeGetAnotherProduct
    )
  end

  def ensure_can_run!
    raise Interactions::Errors::VendingMachineNotInitialized if vending_machine.nil?
  end
end
