module MtGox
  class Client
    include MtGox::Connection
    include MtGox::Request

    # Fetch the latest ticker data
    #
    # @example
    #   MtGox.ticker
    #   MtGox.ticker :eur
    #
    # @authenticated false
    # @return [MtGox::Ticker]
    def ticker(currency=nil)
      currency = currency_name(currency)
      data = get("/api/1/#{currency}/public/ticker?raw")
      Ticker.new(data)
    end

    # Fetch depth
    #
    # @example
    #
    #   MtGox.depth
    #   MtGox.depth(:full => true)
    #   MtGox.depth(:eur, :full => true)
    #
    # @authenticated false
    # @overload depth([currency=:usd,] o={})
    #   @param [Hash] o options
    #   @option o [Boolean] :full full depth
    #   @return [Depth] with keys :asks and :asks, which contain arrays as described in {MtGox::Client#asks} and {MtGox::Clients#bids}
    def depth(*args) 
      (currency,), o = args.extract_options
      currency = currency_name(currency)
      depth = o[:full] ? "fulldepth" : "depth"
      data = get("/api/1/#{currency}/public/#{depth}?raw")
      Depth.new data
    end

    # Fetch recent trades
    #
    # @example
    #   MtGox.trades
    #   MtGox.trades :since => 0
    #   MtGox.trades :eur, :since => 0
    #
    # @authenticated false
    # @return [Array<MtGox::Trade>] an array of trades, sorted in chronological order
    def trades(*args)
      (currency,), query = args.extract_options
      currency = currency_name(currency)
      get("/api/1/#{currency}/public/trades?raw", query).map { |data|
        Trade.new(data)
      }
    end

  protected
    # :usd => "BTCUSD
    def currency_name(symbol=nil)
      symbol ||= MtGox.currency
      "BTC#{symbol.upcase}"
    end
  end
end
