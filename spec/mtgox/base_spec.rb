require "spec_helper"

class MyBase < MtGox::Base
  @@attributes = [:foo, :bar]
  attr_accessor *@@attributes
end

describe MtGox::Base do
  before :each do
    @base = MyBase.new("foo" => 1, "bar" => 2)
  end

  describe "#inspect" do
    it "works" do
      @base.inspect.should =~ /#<.* @foo=1, @bar=2>/
    end
  end

  describe "#to_hash" do
    it "works" do
      @base.to_hash.should == {foo: 1, bar: 2}
    end

    it "return only some keys" do
      @base.to_hash(:foo).should == {foo: 1}
    end
  end
end

