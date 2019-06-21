class ScoreFunctionBuilder

  def function
    {}
  end

=begin
  The name of this score function.
=end
  def name
    return self.class::NAME
  end

end