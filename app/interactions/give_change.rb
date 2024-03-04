class Interactions::GiveChange < Interactions::Base
  def run
    return if no_change_needed?
    give_change
  end

  def ensure_can_run!
    raise Interactions::Errors::VendingMachineNotInitialized if vending_machine.nil?
    raise Interactions::Errors::NoCoinsInserted if vending_machine.inserted_coins.nil?
  end

  private

  def no_change_needed?
    vending_machine.no_change_needed?
  end

  def give_change
    print_message("Please take your change from the change compartment: #{change_stringified}")
  rescue VendingMachine::ChangeCalculator::NotEnoughCoinsForChange
    print_warning("Sorry we don't have enough coins for change")
  end

  def change_stringified
    vending_machine.get_change.map do |change_coins|
      "#{change_coins[:value]} * #{change_coins[:count]}"
    end.join(" + ")
  end
end
