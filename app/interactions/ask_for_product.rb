class Interactions::AskForProduct < Interactions::Base
  def run
    ask_for_product
    get_slot_id
  end

  def ensure_can_run!
    raise Errors::NoCoinsInserted if inserted_coins.nil?
    raise Errors::VendingMachineNotInitialized if vending_machine.nil?
  end

  private

  attr_reader :slot_id

  def ask_for_product
    print_message("Please choose the product.")
    print_hint("To do so type in the product slot number. Only one product can be selected.")
  end

  def get_slot_id
    @slot_id = get_input_number

    verify_slot_id_and_save
  end

  def verify_slot_id_and_save
    return process_no_product if slot_id.nil?
    return process_invalid_slot_id if slot_id_invalid?
    return process_not_enough_money if not_enough_money?
    
    Store[:selected_slot_id] = slot_id
  end

  def process_invalid_slot_id
    print_warning("No slot with such ID found. Please try again.")

    get_slot_id
  end

  def process_no_product
    print_warning("No product selected. Please try again.")

    get_slot_id
  end

  def process_not_enough_money
    print_warning("There is not enough money inserted.")

    print_message("Would you like to insert a different number coins? (y/n)")

    reinsert_coins if get_input_boolean

    print_message("Please choose the product.")

    get_slot_id
  end

  def reinsert_coins
    Interactions.run(Interactions::AskForCoins)
  end

  def slot_id_invalid?
    !vending_machine.slot_available?(slot_id)
  end

  def not_enough_money?
    total_sum < vending_machine.get_product_cost(slot_id)
  end

  def total_sum
    inserted_coins.inject(:+)
  end

  def vending_machine
    Store[:vending_machine]
  end

  def inserted_coins
    Store[:inserted_coins]
  end
end
