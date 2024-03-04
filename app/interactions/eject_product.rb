class Interactions::EjectProduct < Interactions::Base
  def run
    notify_ejection
    reduce_product_count
  end

  def ensure_can_run!
    raise Errors::VendingMachineNotInitialized if vending_machine.nil?
    raise Errors::NoProductSelected if vending_machine.selected_slot_id.nil?
  end

  private

  def notify_ejection
    print_message("Please take your product from the output compartment.")
  end

  def reduce_product_count
    vending_machine.reduce_selected_product_count
  end
end
