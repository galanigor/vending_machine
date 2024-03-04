class VendingMachine
  class SlotIdTaken < StandardError; end

  AVAILABLE_COINS = [0.25, 0.5, 1, 2, 3, 5].freeze

  attr_reader :slots
  attr_accessor :inserted_coins, :selected_slot_id

  def self.invalid_coins(coins)
    coins - AVAILABLE_COINS
  end

  def initialize
    @slots = []
  end

  def add_slot(slot)
    validate_slot_id!(slot.id)
  
    slots << slot
  end

  def get_product_cost(slot_id)
    get_slot_by_id(slot_id).product_cost
  end

  def slot_available?(slot_id)
    slots.any? { |slot| slot.id == slot_id } 
  end

  def product_out_of_stock?(slot_id)
    get_slot_by_id(slot_id).out_of_stock?
  end

  def reduce_selected_product_count
    selected_slot.reduce_product_count
  end

  def inserted_sum
    inserted_coins.inject(:+)
  end

  def no_change_needed?
    inserted_sum == selected_slot.product_cost
  end

  def get_change
    VendingMachine::ChangeCalculator.call(inserted_sum, selected_slot.product_cost)
  end

  def reset_inputs
    inserted_coins = nil
    selected_slot_id = nil
  end

  private
  
  def validate_slot_id!(slot_id)
    return if !slots.map(&:id).include?(slot_id) 

    raise SlotIdTaken.new("Slot ID #{slot_id} have already been taken.")
  end

  def get_slot_by_id(slot_id)
    slots.find { |slot| slot.id == slot_id }
  end

  def selected_slot
    get_slot_by_id(selected_slot_id)
  end
end
