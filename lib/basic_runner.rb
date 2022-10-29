require 'fail'

class Runner
  attr_accessor :test_space
  def initialize; end

  def expects
    yield
  end

  def to_be(*args, bool_value)
    if [TrueClass, FalseClass].include?(bool_value.class)
      block = yield
      pass_fail = block == bool_value
      unless pass_fail
        return Fail.new(block, bool_value)
      end
      return Pass.new(block, bool_value)
    else
      raise ArgumentError, "Expected a boolean, got #{bool_value.class}"
    end
  end

  def to_eq(*args, value)
    # value is the value against which we compare the passed block
    value_class = value.class
    block = yield
    similar_class = block.class == value_class

    unless similar_class
      if block.class == String or value_class == String
        return Fail.new(block, value, message: "Class mismatch between the expected value: '#{value}', and the actual value '#{block}'")
      else
        return Fail.new(block, value, message:" Class mismatch between the expected value #{value} and actual value #{block}")
      end
    end
    
    return Pass.new(block, value)
  end

  def it(string)
    yield
  end
end
