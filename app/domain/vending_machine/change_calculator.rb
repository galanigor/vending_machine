class VendingMachine::ChangeCalculator
  def self.call(total_sum, used_sum)
    new(total_sum, used_sum).call
  end

  def initialize(total_sum, used_sum)
    @total_sum = total_sum
    @used_sum = used_sum
  end

  def call
    prepare_change

    change
  end

  private

  attr_reader :total_sum, :used_sum

  def prepare_change
    VendingMachine::AVAILABLE_COINS.sort.reverse.inject(leftover) do |recidue, coin|
      next recidue if recidue == 0 || recidue < coin
      
      change << { value: coin, count: (recidue / coin).floor }
      
      recidue % coin
    end
  end

  def leftover
    total_sum - used_sum
  end

  def change
    @change ||= []
  end
end
