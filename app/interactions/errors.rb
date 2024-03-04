module Interactions::Errors
  class NoCoinsInserted < StandardError; end
  class VendingMachineNotInitialized < StandardError; end
  class NoProductSelected < StandardError; end
end
