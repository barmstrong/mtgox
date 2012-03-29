require "spec_helper"

describe MtGox::Me do
  before :all do
    @me = MtGox::Me.new
  end

  describe "#info" do
    it "works" do
      stub_post("/api/1/generic/private/info?raw")
        .with(:body => test_body, :headers => test_headers)
        .to_return(:status => 200, :body => fixture("info.json"))

      @me.info
    end
  end

  describe "#id_key" do
    it "works" do
      stub_post("/api/1/generic/private/idkey")
        .with(:body => test_body, :headers => test_headers)
        .to_return(:status => 200, :body => fixture("id_key.json"))

     id_key = @me.id_key
      id_key.should == "id_key"
    end
  end

  describe "#orders" do
    it "works" do
      stub_post("/api/1/generic/private/orders?raw")
        .with(:body => test_body, :headers => test_headers)
        .to_return(:status => 200, :body => fixture("orders.json"))

      o = @me.orders[0]

      o.oid.should == 1
      o.currency.should == "USD"
      o.item.should == "BTC"
      o.type.should == "bid"
      o.amount.should == 1.65000000
      o.price.should == 1.65000
      o.status.should == "open"
      o.date.should == Time.at(1332896128)
      o.priority.should == 1332896128221516
    end
  end

  describe "#trades" do
    it "works" do
      stub_post("/api/1/generic/private/trades?raw")
        .with(:body => test_body, :headers => test_headers)
        .to_return(:status => 200, :body => fixture("trades.json"))

      t = @me.trades[0]
      t.should be_an_instance_of MtGox::Trade
    end
  end

  describe "#add" do
    it "works" do
      body = test_body("type"=>"bid", "amount_int"=>"10000", "price_int"=>"100000")
      stub_post("/api/1/BTCUSD/private/order/add")
        .with(:body => body, :headers => test_headers(body))
        .to_return(:status => 200, :body => fixture("add.json"))


      @me.add("bid", 1*10000, 1*100000)
    end
  end
end
