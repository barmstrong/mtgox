module MtGox
  class Depth < Base
    @@attributes = [ :asks, :bids ]

    attr_reader *@@attributes

    def asks=(raw)
      @asks = raw.map{|v| Ask.new(v)}
    end

    def bids=(raw)
      @bids = raw.map{|v| Bid.new(v)}
    end
  end
end
