class Interactions::ShowVendingMachineSlots < Interactions::Base
  def run
    print_vending_machine_slots_message
  end

  def ensure_can_run!
    raise Errors::VendingMachineNotInitialized if vending_machine.nil?
  end

  private

  def vending_machine
    @vending_machine ||= Store[:vending_machine]
  end

  def print_vending_machine_slots_message
    print_message("-----------------------")
    print_message(vending_machine_slots_stringified)
    print_message("-----------------------")
  end

  def vending_machine_slots_stringified
    vending_machine.slots.map do |slot|
      "#{slot.id}: #{slot.product_name} (#{slot.product_count}) - #{slot.product_cost}"
    end
  end
end
