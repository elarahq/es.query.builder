class ScriptSortTypes

  SCRIPT_SORT_TYPES = {number: "number", string: "string"}

  attr_reader :script_sort_type

  SCRIPT_SORT_TYPES.keys.each do |script_type|
    define_singleton_method(script_type) do
      return self.new(SCRIPT_SORT_TYPES[script_type])
    end
  end

  def initialize script_type
    @script_sort_type = script_type
  end

end