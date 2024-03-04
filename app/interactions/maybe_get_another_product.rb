class Interactions::MaybeGetAnotherProduct < Interactions::Base
  def run
    ask_for_another_product
    get_answer
    return get_another_product if get_another_product?
    wish_good_luck
  end

  private

  attr_reader :answer

  def ask_for_another_product
    print_message("Would you like to get another product? (y/n)")
  end

  def get_answer
    @answer = get_input_boolean
  end

  def get_another_product?
    answer
  end

  def get_another_product
    Interactions.run(Interactions::GetProduct)
  end

  def wish_good_luck
    print_message("Enjoy you purchase! Good luck!")
  end
end
