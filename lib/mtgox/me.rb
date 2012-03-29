module MtGox
  class Me < Client
    def info
      post("/api/1/generic/private/info?raw")
    end

    def id_key
      post("/api/1/generic/private/idkey")["return"]
    end

    def orders
      post("https://mtgox.com/api/1/generic/private/orders?raw").map {|data|
        Order.new(data)
      }
    end

    def trades
      post("https://mtgox.com/api/1/generic/private/trades?raw").map { |data|
        Trade.new(data)
      }
    end

    # add a order
    def add(type, amount_int, price_int, currency=:usd)
      currency = currency_name(currency) 
      query = {type: type, amount_int: amount_int, price_int: price_int}
      post("https://mtgox.com/api/1/#{currency}/private/order/add", query)
    end
  end
end
