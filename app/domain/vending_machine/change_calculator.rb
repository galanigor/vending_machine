class VendingMachine::ChangeCalculator
  class NotEnoughCoinsForChange < StandardError; end
  
  def self.call(total_sum, used_sum, stored_coins)
    new(total_sum, used_sum, stored_coins).call
  end

  def initialize(total_sum, used_sum, stored_coins)
    @total_sum = total_sum
    @used_sum = used_sum
    @stored_coins = stored_coins
    @change_recidue = 0
  end

  def call
    prepare_change
    validate_change!

    change
  end

  private

  attr_reader :total_sum, :used_sum, :stored_coins, :change_recidue

  def prepare_change
    @change_recidue = VendingMachine::AVAILABLE_COINS.sort.reverse.inject(leftover) do |recidue, coin|
      next recidue if recidue == 0 || recidue < coin

      required_change_count = (recidue / coin).floor
      available_change_count = stored_coins[coin]
      actual_change_count = [required_change_count, available_change_count].min
      
      change << { value: coin, count: actual_change_count } if actual_change_count > 0
      
      recidue - (coin * actual_change_count)
    end
  end

  def leftover
    total_sum - used_sum
  end

  def change
    @change ||= []
  end

  def validate_change!
    raise NotEnoughCoinsForChange if @change_recidue > 0
  end
end
