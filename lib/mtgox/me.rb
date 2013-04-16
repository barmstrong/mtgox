module MtGox
  class Me < Client
    ORDER_TYPES = {ask: 1, bid: 2}

    def info
      post("/api/1/generic/private/info")["return"]
    end

    def id_key
      post("/api/1/generic/private/idkey")["return"]
    end

    def orders
      post("/api/1/generic/private/orders")["return"].map {|data|
        Order.new(data)
      }
    end

    def trades
      post("/api/1/generic/private/trades")["return"].map { |data|
        Trade.new(data)
      }
    end

    # this method call matches the advanced search params you can do on https://mtgox.com/trade/account-history
    # valid options: currency, type, date_start, date_end, trade_id, page
    # type can be ones of: deposit, withdraw, fee, in, out spent earned
    # currency is a required param, different results are shown depending if you use 'BTC' or your native currency
    def wallet_history options={}
      options[:currency] ||= 'BTC'
      post('/api/1/generic/wallet/history', options)['return']['result']
    end

    # add an order
    #
    # @example
    #
    #  add(:bid, 1*1000, 5.3*1000)  # buy 1 BTC at $5.3
    def add(type, amount_int, price_int, currency=nil)
      currency = currency_name(currency) 
      query = {type: type, amount_int: amount_int, price_int: price_int}
      post("/api/1/#{currency}/private/order/add", query)["return"]
    end

    # cancel an order.
    # @note THIS API FROM V0.
    #
    # @example
    #  
    #  cancel(:bid, "76a5986a-a122-4363-b16b-15f12bffb88c")
    def cancel(type, oid)
      if orders.find{|t| t.oid == oid }
        type = ORDER_TYPES[type.to_sym]
        query = {oid: oid}
        post("/api/1/generic/private/order/cancel", query)
        true
      else
        raise Faraday::Error::ResourceNotFound, {:status => 404, :headers => {}, :body => "Order not found."}
      end
    end
  end
end
