class Interactions::ShowVendingMachineSlots < Interactions::Base
  def run
    print_vending_machine_slots
    print_format_hint
  end

  def ensure_can_run!
    raise Interactions::Errors::VendingMachineNotInitialized if vending_machine.nil?
  end

  private

  def vending_machine
    @vending_machine ||= Store[:vending_machine]
  end

  def print_vending_machine_slots
    print_message("-----------------------")
    print_message(vending_machine_slots_stringified)
    print_message("-----------------------")
  end

  def print_format_hint
    print_hint("The vending machine slot display format is 'slot_id: product_name (product_count) - product_cost'")
  end

  def vending_machine_slots_stringified
    vending_machine.slots.map do |slot|
      "#{slot.id}: #{slot.product_name} (#{slot.product_count}) - #{slot.product_cost}"
    end
  end
end
