require "spec_helper"

OID = "76a5986a-a122-4363-b16b-15f12bffb88c"

describe MtGox::Me do
  before :all do
    @me = MtGox::Me.new
  end

  describe "#info" do
    it "works" do
      stub_post("/api/1/generic/private/info")
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
      stub_post("/api/1/generic/private/orders")
        .with(:body => test_body, :headers => test_headers)
        .to_return(:status => 200, :body => fixture("orders.json"))

      o = @me.orders[0]

      o.oid.should == OID
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
      stub_post("/api/1/generic/private/trades")
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

  describe "#cancel" do
    before :each do
      body = test_body("oid"=>OID)

      stub_post("/api/1/generic/private/order/cancel")
        .with(:body => body, :headers => test_headers(body))
        .to_return(:status => 200, :body => fixture("cancel.json"))
      
      stub_post("/api/1/generic/private/orders")
        .with(:body => test_body, :headers => test_headers)
        .to_return(:status => 200, :body => fixture("orders.json"))
    end

    it "works" do
      @me.cancel(OID)
    end

    it "raises error with wrong oid" do
      lambda{ @me.cancel("wrong_oid") }.should raise_error Faraday::Error::ResourceNotFound
    end
  end
end
