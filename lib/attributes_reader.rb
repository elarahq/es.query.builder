module AttributesReader

  class Attributes

    def initialize parent_object
      @parent_object = parent_object
    end

    def method_missing(m, *args, &block)
      if @parent_object.methods.include?("#{m}_expr".intern)
        @parent_object.send("#{m}_expr", *args)
      else
        raise MissingAttributeError.new(m, @parent_object.class)
      end
    end

  end

  class MissingAttributeError < StandardError

    def initialize attr_name, class_name
      @attr = attr_name
      @class = class_name
      super(message)
    end

    def message
      return "Missing Attribute #{@attr} for #{@class}"
    end

  end


  def attributes
    @attributes ||= Attributes.new(self)
    return @attributes
  end

end
