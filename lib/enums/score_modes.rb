class ScoreModes

  SCORE_MODES = {multiply: 'multiply', sum: 'sum', avg: 'avg', first: 'first', max: 'max', in: 'min'}

  attr_reader :score_mode

  SCORE_MODES.keys.each do |sc_md|
    define_singleton_method(sc_md) do
      return self.new(SCORE_MODES[sc_md])
    end
  end

  def initialize value
    @score_mode = value
  end
  
end