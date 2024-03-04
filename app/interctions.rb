module Interactions
  def self.run(*interactions)
    interactions.each do |interaction|
      interaction.ensure_can_run!
      interaction.run
    end
  end

  class Base
    class << self
      def run
        new.run
      end
  
      def ensure_can_run!
        new.ensure_can_run!
      end
    end

    def ensure_can_run!; end

    private
  
    def print_message(message)
      puts message
    end
  
    def print_hint(message)
      puts "*** #{message}"
    end
  
    def print_warning(message)
      puts "!!! #{message}"
    end
  
    def get_input
      STDIN.gets.chomp
    end

    def get_input_numbers
      get_input.split(/\s*,\s*/).map do |input_item|
        Integer(input_item, exception: false) || Float(input_item, exception: false)
      end
    end

    def get_input_number
      get_input_numbers.first
    end

    def get_input_boolean
      ["y", "Y"].include?(get_input)
    end

    def vending_machine
      Store[:vending_machine]
    end
  end
end
