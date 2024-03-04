class VendingMachine
  class SlotIdTaken < StandardError; end

  AVAILABLE_COINS = [0.25, 0.5, 1, 2, 3, 5].freeze

  attr_reader :slots

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
    slots.find { |slot| slot.id == slot_id }.product_cost
  end

  def slot_available?(slot_id)
    slots.any? { |slot| slot.id == slot_id } 
  end

  private
  
  def validate_slot_id!(slot_id)
    return if !slots.map(&:id).include?(slot_id) 

    raise SlotIdTaken.new("Slot ID #{slot_id} have already been taken.")
  end
end
