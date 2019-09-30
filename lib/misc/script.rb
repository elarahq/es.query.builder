# frozen_string_literal: true

module Misc
  # Script represents used-defined input that can be used to compile and
  # execute a script from the ScriptService based on the ScriptType.
  class Script
    include AttributesReader

    # @param [String] id_or_code
    # @param [Hash] params
    # @param [Enums::ScriptTypes] type : Enums::ScriptTypes.(inline|stored),
    #   defaults to Enums::ScriptTypes.inline
    # @param [String] lang
    # @param [Hash] options
    def initialize(id_or_code:, params: {}, type: Enums::ScriptTypes.inline, lang: 'painless', options: {})
      @id_or_code = id_or_code
      @params = params
      @type = type
      @lang = lang
      @options = options
    end

    # return [Hash]
    def settings
      settings = {}
      if @type.script_type == Enums::ScriptTypes.inline.script_type
        settings[:source] = @id_or_code
      else
        settings[:id] = @id_or_code
      end
      settings[:lang] = @lang if @lang.present?
      settings[:params] = @params if @params.present?
      settings[:options] = @options if @options.present?
      settings
    end

    # @return [String]
    def id_or_code_expr
      @id_or_code
    end

    # @return [Hash]
    def params_expr
      @params
    end

    # @return [Enums::ScriptTypes]
    def type_expr
      @type
    end

    # @return [String]
    def lang_expr
      @lang
    end

    # @return [Hash]
    def options_expr
      @options
    end
  end
end
