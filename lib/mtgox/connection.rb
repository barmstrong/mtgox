require "faraday"
require "mtgox/response/raise_mtgox_error"
require "faraday_middleware"
require "faraday_middleware/response/parse_json"

module MtGox
  module Connection
    private

    def connection
      options = {
        :headers  => {
          :accept => "application/json",
          :user_agent => "mtgox gem #{MtGox::VERSION}"
        },
        :ssl => {:verify => false},
        :url => "https://data.mtgox.com",
      }

      Faraday.new(options) do |c|
        #c.use Faraday::Response::Logger
        c.use Faraday::Request::UrlEncoded
        c.use Faraday::Response::RaiseError
        c.use FaradayMiddleware::ParseJson
        c.use MtGox::Response::RaiseMtGoxError
        c.adapter(Faraday.default_adapter)
      end
    end
  end
end
