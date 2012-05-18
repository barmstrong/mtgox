module MtGox
  class Trade < Base
    cattr_reader :attributes
    @@attributes = [:date, :price, :price_int, :amount, :amount_int, :tid, :price_currency, :item, :trade_type, :primary, :properties]

    attr_accessor *@@attributes

    # Fixnum
    def tid=(raw)
      @tid = raw.to_i
    end

    def date=(raw)
      @date = Time.at(raw)
    end

    def price=(raw)
      @price = raw.to_f
    end

    def amount=(raw)
      @amount = raw.to_f
    end

    def price_int=(raw)
      @price_int = raw.to_i
    end

    def amount_int=(raw)
      @amount_int = raw.to_i
    end
  end
end
