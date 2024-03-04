class VendingMachine
  class SlotIdTaken < StandardError; end
  class NoSlotWithId < StandardError; end
  class InvalidCoinsFound < StandardError; end

  AVAILABLE_COINS = [0.25, 0.5, 1, 2, 3, 5].freeze

  attr_reader :slots
  attr_accessor :inserted_coins, :selected_slot_id

  def self.invalid_coins(coins)
    coins - AVAILABLE_COINS
  end

  def initialize
    @slots = []
    @inserted_coins = []
    @stored_coins = AVAILABLE_COINS.zip(Array.new(AVAILABLE_COINS.count) { 0 }).to_h
  end

  def add_slot(id:, product_name:, product_count:, product_cost:)
    validate_slot_id!(id)
  
    slots << Slot.new(id, product_name, product_count, product_cost)
  end

  def select_slot(slot_id)
    @selected_slot_id = slot_id

    get_slot_by_id(slot_id)
  end

  def insert_coins(coins)
    validate_coins!(coins)

    @inserted_coins = coins

    store_coins(coins)
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
    inserted_coins.inject(:+) || 0
  end

  def no_change_needed?
    inserted_sum == selected_slot.product_cost
  end

  def get_change
    VendingMachine::ChangeCalculator.call(inserted_sum, selected_slot.product_cost, stored_coins).tap do |change|
      remove_stored_coins(change)
    end
  end

  def reset_inputs
    inserted_coins = []
    selected_slot_id = nil
  end

  def get_slot_by_id(slot_id)
    slots.find { |slot| slot.id == slot_id }.tap do |slot|
      raise NoSlotWithId if slot.nil?
    end
  end

  def selected_slot
    get_slot_by_id(selected_slot_id)
  end

  def store_coins(coins)
    validate_coins!(coins)

    coins.each { |coin| stored_coins[coin] += 1 }
  end

  private

  attr_reader :stored_coins
  
  def validate_slot_id!(slot_id)
    return if !slots.map(&:id).include?(slot_id) 

    raise SlotIdTaken.new("Slot ID #{slot_id} have already been taken.")
  end

  def validate_coins!(coins)
    raise InvalidCoinsFound if !self.class.invalid_coins(coins).empty?
  end

  def remove_stored_coins(change)
    change.each { |coins| stored_coins[coins[:value]] -= coins[:count] }
  end
end
