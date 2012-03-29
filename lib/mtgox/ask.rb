module MtGox
  class AskBase < Base
    @@attributes = [:price, :amount, :price_int, :amount_int, :stamp]

    attr_accessor *@@attributes

    def price_int=(raw)
      @price_int = raw.to_i
    end

    def amount_int=(raw)
      @amount_int = raw.to_i
    end
  end

  class Ask < AskBase
  end

  class Bid < AskBase
  end
end

