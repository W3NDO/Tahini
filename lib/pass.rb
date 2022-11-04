require_relative 'result'

class Pass < Result
  attr_accessor :lhs, :rhs

  def initialize(lhs, rhs)
    if lhs != rhs or lhs.class != rhs.class
      raise ArgumentError, "Actual and expected values are not similar"
    end
    self.lhs = lhs
    self.rhs = rhs
  end

end
