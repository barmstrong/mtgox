module MtGox
  class Base
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
  end
end
