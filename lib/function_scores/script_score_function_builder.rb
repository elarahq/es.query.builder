class ScriptScoreFunctionBuilder < ScoreFunctionBuilder

  NAME = 'script_score'

  attr_reader :script

  def initialize script
    @script = script
  end

  def function
    function = {}
    ss_query = super
    ss_query[:script] = script.query
    function[name.intern] = ss_query
    return function
  end

end
