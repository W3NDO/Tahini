require_relative 'result'

# require 'colorize'

class Runner
  attr_accessor :test_space
  # the test space is a hash. it will hold the scope of the test and the returned result pass/fail object
  def initialize
    self.test_space = {}
  end

  def add_to_test_space(name, result) # collate all tests into the test space hash
    # test_space.has_key?(name) ? test_space[name] << result : test_space[name] = [result]
    test_space[name.to_sym] << result if test_space.respond_to?(name.to_sym)
    test_space[name] = [result] unless test_space.respond_to?(name.to_sym)

    # can optimise this with metaprogramming? Use respond_to? instead
  end

  def expects
    yield
  end

  def to_be(bool_value)
    if [TrueClass, FalseClass].include?(bool_value.class)
      block = yield
      pass_fail = block == bool_value
      unless pass_fail
        return Result::Fail.new(block, bool_value)
      end
      return_test_results
      return Result::Pass.new(block, bool_value)
    else
      raise ArgumentError, "Expected a boolean, got #{bool_value.class}"
    end
  end

  def to_eq(value)
    # value is the value against which we compare the passed block
    value_class = value.class
    block = yield
    similar_class = (block.class == value_class)

    unless similar_class
      if block.class == String or value_class == String
        return Result::Fail.new(block, value, message: "Class mismatch between the expected value: '#{value}', and the actual value '#{block}'")
      else
        return Result::Fail.new(block, value, message:" Class mismatch between the expected value #{value} and actual value #{block}")
      end
    end
    return_test_results
    return Result::Pass.new(block, value)
  end

  def collections_to_eq(value)
    # this method is to be used when comparing collection class objects like arrays, hashes, sets and ranges
    # As of now it only supports Arrays and Hashes
    supported_collections = [Array, Hash]
    block = yield
    unless supported_collections.include?(value.class)
      return Result::Fail.new(block, value, message: "#collections_to_eq only compares Array or Hash objects. '#{value}' is not a valid collection at this time")
    end

    unless supported_collections.include?(block.class)
      return Result::Fail.new(block, value, message: "#collections_to_eq only compares Array or Hash objects. The evaluated result, '#{block}', is not a valid collection at this time.")
    end

    return Result::Pass.new(block, value)
  end

  def it(string)
    add_to_test_space(string, yield)
  end

  def return_test_results
    fail_count = 0
    pass_count = 0
    current_test = []
    failures = {}
    begin
      self.test_space.each do |test, result|
        current_test = [test, result]
        if result.class == Result::Fail
          fail_count += 1
          failures[fail_count] = "#{fail_count}. \n FAIL : #{result.message} \n \t lhs : #{result.lhs} \n \t rhs : #{result.rhs} "
          pp "F".red
        elsif result.class == Result::Pass
          pass_count += 1
          pp "."
        end
      end
    rescue
      puts "There was an issue running #{current_test[0]}"
    end
    pp "#{Result::Pass.new(1,1).class} - Test Space"
    pp "#{fail_count} tests failed"
    pp "#{pass_count} tests passed"
  end
end
