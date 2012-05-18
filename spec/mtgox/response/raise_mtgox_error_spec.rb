require "spec_helper"

describe "raise_mtgox_error" do
  it "works" do
    c = MtGox::Client.new
    stub_post("/foo").to_return(:status => 200, :body => "MySQL error, please retry later")

    lambda{ c.post("/foo") }.should raise_error(MtGox::MysqlError)
  end
end
