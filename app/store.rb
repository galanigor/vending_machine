class Store
  class << self
    def init_store
      @@store = {}
    end

    def [](key)
      @@store[key]
    end

    def []=(key, value)
      @@store[key] = value
    end
  end

  init_store
end
