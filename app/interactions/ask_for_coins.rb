class Interactions::AskForCoins < Interactions::Base
  def run
    ask_for_coins
    get_coins
  end

  private

  attr_reader :coins

  def ask_for_coins
    print_message("Please insert coins. Available coins: #{VendingMachine::AVAILABLE_COINS.map(&:to_s).join(", ")}")
    print_hint("To insert multiple coins, type them in using the ',' separation.")
  end

  def get_coins
    @coins = get_input_numbers

    verify_coins_and_save
  end

  def verify_coins_and_save
    return process_invalid_coins if !invalid_coins.empty?
    return process_no_coins if coins.empty?
    
    print_message("You have inserted a total of #{coins.inject(:+)} coins.")

    Store[:inserted_coins] = coins
  end

  def process_invalid_coins
    print_warning("Unavailable coins detected: #{invalid_coins.join(', ')}. Please try again.")

    get_coins
  end

  def process_no_coins
    print_warning("No coins detected. Please try again.")

    get_coins
  end

  def invalid_coins
    VendingMachine.invalid_coins(coins)
  end
end
