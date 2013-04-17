unless ENV["CI"]
  require "simplecov"
  SimpleCov.start
end
require "bundler/setup"
require "pd"
require "base64"
require "mtgox"
require "webmock/rspec"

module MtGox
  module Request
    private
    def add_nonce(options)
      options.merge!({:nonce => 1321745961249676})
    end
  end
end

MtGox.configure do |c|
  c.key = "key"
  c.secret = "secret"
end

def a_get(path)
  a_request(:get, "https://data.mtgox.com" + path)
end

def stub_get(path)
  stub_request(:get, "https://data.mtgox.com" + path)
end

def a_post(path)
  a_request(:post, "https://data.mtgox.com" + path)
end

def stub_post(path)
  stub_request(:post, "https://data.mtgox.com#{path}")
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + "/" + file)
end

def test_headers(body=test_body)
  signed_headers(body).merge!(
    {
      "Accept" => "*/*",
      "Content-Type" => "application/x-www-form-urlencoded",
      "User-Agent" => "Ruby",
    }
  )
end

def signed_headers(body)
  signature = Base64.strict_encode64(
    OpenSSL::HMAC.digest "sha512",
    Base64.decode64(MtGox.secret),
    body
  )
  {"Rest-Key" => MtGox.key, "Rest-Sign" => signature}
end

def test_body(options={})
  options.merge!({:nonce => 1321745961249676}).collect{|k, v| "#{k}=#{v}"} * "&"
end
