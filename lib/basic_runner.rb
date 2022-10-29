class Runner
  attr_accessor :test_space
  def initialize; end

  def expects
    yield
  end

  def to_be(*args, bool_value)
    if [TrueClass, FalseClass].include?(bool_value.class)
      block = yield
      return block == bool_value
    else
      raise ArgumentError, "Expected a boolean, got #{bool_value.class}"
    end
  end

  def to_eq

  end

  def it(string)
    yield
  end
end
