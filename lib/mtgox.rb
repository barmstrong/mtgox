libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require "tagen/core/array/extract_options"
require "active_support/core_ext/class/attribute_accessors"
require "pd"

module MtGox
  autoload :VERSION, "mtgox/version"
  autoload :Client, "mtgox/client"
  autoload :Me, "mtgox/me"
  autoload :Configuration, "mtgox/configuration"
  autoload :Connection, "mtgox/connection"
  autoload :Request, "mtgox/request"
  autoload :Base, "mtgox/base"
  autoload :Ticker, "mtgox/ticker"
  autoload :Trade, "mtgox/trade"
  autoload :Depth, "mtgox/depth"
  autoload :AskBase, "mtgox/ask"
  autoload :Ask, "mtgox/ask"
  autoload :Bid, "mtgox/ask"
  autoload :Order, "mtgox/order"

  Error  = Class.new StandardError
  MysqlError = Class.new Error

  extend Configuration

  class << self
    # Alias for MtGox::Client.new
    #
    # @return [MtGox::Client]
    def new
      Client.new
    end

    def me
      @@me ||= Me.new
    end

    # Delegate to MtGox::Client
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
