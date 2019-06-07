class Script

  TYPES = [:INLINE, :STORED]

  def initialize id_or_code, params={}, type=TYPES[0], lang='painless', options={}
    @id_or_code = id_or_code
    @params = params
    @type = TYPES.include?(type) ? type : TYPES[0]
    @lang = lang
    @options = options
  end

  def get_id_or_code
    @id_or_code
  end

  def type type
    @type = type
    self
  end

  def get_type
    @type
  end

  def lang lang
    @lang = lang
    self
  end

  def get_lang
    @lang
  end

  def params params
    @params = params
    self
  end

  def get_params
    @params
  end

  def options options
    @options = options
    self
  end

  def get_options
    @options
  end

  def get_script
    @script = {}
    if @type.to_sym == TYPES[0]
      @script['source'] = @id_or_code
    else
      @script['id'] = @id_or_code
    end
    @script['lang'] = @lang if @lang.present?
    @script['params'] = @params if @params.present?
    @script['options'] = @options if @options.present?
    @script
  end

end