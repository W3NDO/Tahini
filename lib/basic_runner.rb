require 'fail'

class Runner
  attr_accessor :test_space
  # the test space is a hash. it will hold the scope of the test and the returned result pass/fail object
  def initialize
    self.test_space = {}
  end

  def add_to_test_space(name, result)
    test_space.has_key?(name) ? test_space[name] << result : test_space[name] = [result]
  end

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

  def to_eq(value)
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

  def collections_to_eq(value)
    # this method is to be used when comparing collection class objects like arrays, hashes, sets and ranges
    # As of now it only supports Arrays and Hashes
    supported_collections = [Array, Hash]
    block = yield
    unless supported_collections.include?(value.class)
      return Fail.new(block, value, message: "#collections_to_eq only compares Array or Hash objects. '#{value}' is not a valid collection at this time")
    end

    unless supported_collections.include?(block.class)
      return Fail.new(block, value, message: "#collections_to_eq only compares Array or Hash objects. The evaluated result, '#{block}', is not a valid collection at this time.")
    end
    
    return Pass.new(block, value)
  end

  def it(string)
    yield
  end
end
