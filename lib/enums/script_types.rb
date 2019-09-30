module Enums
  class ScriptTypes

    SCRIPT_TYPES = {:inline => :inline, :stored => :stored}

    attr_reader :script_type

    SCRIPT_TYPES.each do |type, es_value|
      define_singleton_method(type) do
        return self.new(es_value)
      end
    end

    def initialize type
      @script_type = type
    end

  end
end