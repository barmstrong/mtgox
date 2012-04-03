require "spec_helper"

class MtGox::Client
  public :currency_name
end

describe MtGox::Client do
  before do
    @client = MtGox::Client.new
  end

  describe "#currency_name" do
    it "works" do
      @client.currency_name(:usd).should == "BTCUSD"
      @client.currency_name(:eur).should == "BTCEUR"
    end

    it "use MtGox.currency config" do
      begin
        MtGox.currency = :eur
        @client.currency_name.should == "BTCEUR"
      ensure
        MtGox.currency = :usd
      end
    end
  end

  describe "#ticker" do
    it "should fetch the ticker" do
      stub_get("/api/1/BTCUSD/public/ticker?raw")
        .to_return(:status => 200, :body => fixture("ticker.json"))

      t = @client.ticker

      t.buy.should  == 4.75992
      t.sell.should == 4.79907
      t.high.should == 4.84592
      t.low.should  == 4.64116
      t.avg.should == 4.77215
      t.vol.should == 50178.69717970
      t.vwap.should == 4.76327
      t.last_local.should == 4.75992
      t.last.should == 4.75992
      t.last_orig.should == 4.75992
      t.last_all.should == 4.75992
    end

    it "supports multi currency" do
      stub_get("/api/1/BTCEUR/public/ticker?raw")
        .to_return(:status => 200, :body => "{}")

      @client.ticker :eur
    end

  end

  describe "#depth" do
    it "works" do
      stub_get("/api/1/BTCUSD/public/depth?raw")
        .to_return(:status => 200, :body => fixture("depth.json"))

      d = @client.depth

      a = d.asks[0]
      a.price.should == 14.92195
      a.amount.should == 59.99108959
      a.price_int.should == 1492195
      a.amount_int.should == 5999108959
      a.stamp.should == "1332955218813546"
    end

    it "gets fulldepth with :full => true" do
      stub_get("/api/1/BTCUSD/public/fulldepth?raw")
        .to_return(:status => 200, :body => "[]")

      d = @client.depth(:full => true)
    end

    it "supports multi currency" do
      stub_get("/api/1/BTCEUR/public/depth?raw")
        .to_return(:status => 200, :body => "[]")

      @client.depth :eur
    end
  end

  describe "#trades" do
    it "works" do
      stub_get("/api/1/BTCUSD/public/trades?raw")
        .to_return(:status => 200, :body => fixture("trades.json"))

      ts = @client.trades

      t = ts[0]
      t.date.should == Time.at(1332899401)
      t.price.should == 4.75206
      t.amount.should == 0.2
      t.price_int.should == 475206
      t.amount_int.should == 20000000
      t.tid.should == 1332899401871343
      t.price_currency.should == "USD"
      t.item.should == "BTC"
      t.trade_type.should == "ask"
    end

    it "request with :since" do
      stub_get("/api/1/BTCUSD/public/trades?raw&since=0")
        .to_return(:status => 200, :body => "[]")

      @client.trades :since => 0
    end

    it "supports multi currency" do
      stub_get("/api/1/BTCEUR/public/trades?raw")
        .to_return(:status => 200, :body => "[]")

      @client.trades :eur
    end
  end
end
