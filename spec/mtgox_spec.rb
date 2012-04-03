require "spec_helper"

describe MtGox do
  describe ".new" do
    it "should return a MtGox::Client" do
      MtGox.new.should be_a MtGox::Client
    end
  end

  describe ".configure" do
    it "works" do
      MtGox.configure do |c|
        c.key = "key"
        c.secret = "secret"
        c.currency = :usd
      end

      MtGox.key.should == "key"
      MtGox.secret.should == "secret"
      MtGox.currency.should == :usd
    end
  end
end
