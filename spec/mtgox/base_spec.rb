require "spec_helper"

class MyBase < MtGox::Base
  attr_accessor :foo, :bar
end

describe MtGox::Base do
  before :each do
    @base = MyBase.new(foo: 1, bar: 2)
  end

  describe "#inspect" do
    it "works" do
      @base.inspect.should =~ /#<.* @foo=1, @bar=2>/
    end
  end
end

