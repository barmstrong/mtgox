module MtGox
  class Base
    cattr_reader :attributes
    attr_reader :attrs

    def initialize(attrs={})
      @attrs = attrs

      attrs.each {|k, v|
        send "#{k}=", v rescue NoMethodError
      }
    end

    # skip @attrs 
    def inspect
      ret = "#<#{self.class}:0x#{object_id}"

      vars = instance_variables.each.with_object([]) do |n, memo|
        next if n == :@attrs
        memo << "#{n}=#{instance_variable_get(n).inspect}"
      end

      ret << " #{vars.join(", ")}" unless vars.empty?
      ret << ">"

      ret
    end
    alias to_s inspect

    # return a hash version data. 
    #
    # @example
    #
    #  trades.to_hash => {price: 1.0, amount: 2.0, ...
    #  trades.to_hash(:price) => {price: 1.0}
    #
    # @param [Symbol,String] key
    # @return [Hash]
    def to_hash(*keys)
      keys = keys.empty? ? self.class.attributes : keys.map{|v|v.to_sym}

      keys.each.with_object({}) {|k, memo|
        memo[k] = send(k)
      }
    end
  end
end
