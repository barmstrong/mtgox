module MtGox
  class Depth < Base
    attr_reader :asks, :bids

    def asks=(raw)
      @asks = raw.map{|v| Ask.new(v)}
    end

    def bids=(raw)
      @bids = raw.map{|v| Bid.new(v)}
    end
  end
end
