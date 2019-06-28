module Enums
  class ScoreModes

    SCORE_MODES = {multiply: 'multiply', sum: 'sum', avg: 'avg', first: 'first', max: 'max', in: 'min'}

    attr_reader :score_mode

    SCORE_MODES.each do |sc_md, es_value|
      define_singleton_method(sc_md) do
        return self.new(es_value)
      end
    end

    def initialize score_mode
      @score_mode = score_mode
    end
    
  end
end