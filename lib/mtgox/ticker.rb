module MtGox
  class Ticker < Base
    cattr_reader :attributes
    @@attributes = [:high, :low, :avg, :vwap, :vol, :last, :last_local, :last_orig, :last_all, :buy, :sell]

    attr_accessor *@@attributes

    def high=(raw)
      @high = raw["value"].to_f
    end

    def low=(raw)
      @low = raw["value"].to_f
    end

    def avg=(raw)
      @avg = raw["value"].to_f
    end

    def vwap=(raw)
      @vwap = raw["value"].to_f
    end

    def vol=(raw)
      @vol = raw["value"].to_f
    end

    def last=(raw)
      @last = raw["value"].to_f
    end

    def last_local=(raw)
      @last_local = raw["value"].to_f
    end

    def last_orig=(raw)
      @last_orig = raw["value"].to_f
    end

    def last_all=(raw)
      @last_all = raw["value"].to_f
    end

    def buy=(buy)
      @buy = buy["value"].to_f
    end

    def sell=(sell)
      @sell = sell["value"].to_f
    end
  end
end
