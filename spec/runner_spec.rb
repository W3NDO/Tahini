require 'spec_helper'
require_relative '../lib/basic_runner'
require_relative '../lib/result'

RSpec.describe Runner do
  describe "Initializing a new Runner" do
    let(:runner){Runner.new}
    it "creates a new Runner object" do
      expect(runner).to be_instance_of Runner
    end
  end

  describe "Runner#accept" do
    let(:runner){Runner.new}
    it "accepts a string and runs whatever block is passed to it" do
      expect(runner.expects{ true }).to be true
      expect(runner.expects{ 1+1 }).to eq 2
    end
  end

  describe "Runner#to_be" do
    let(:runner){Runner.new}

    it "accepts a string and a boolean and compares against the boolean" do
      expect(runner.to_eq(true){ 1 == 1 }).to have_result_with_lhs_rhs(Result::Pass.new(true, true))
      expect(runner.to_be(false){ 35 < 70 }).to have_result_with_lhs_rhs(Result::Fail.new(true, false))
    end
  end

  describe "Runner#to_eq" do
    let(:runner){Runner.new}

    it "returns a fail if the classes of the expected and actual do not match" do
      expect(runner.to_eq([1,2,3]){"1,2,3"}).to have_result_with_lhs_rhs(Result::Fail.new("1,2,3", [1,2,3], message: "Class mismatch between the expected value: '[1, 2, 3]', and the actual value '1,2,3'"))
    end

    it "correctly compares strings, booleans, numbers" do
      expect(runner.to_eq("hello"){"hello"}).to have_result_with_lhs_rhs(Result::Pass.new("hello", "hello"))
      expect(runner.to_eq(1){1}).to have_result_with_lhs_rhs(Result::Pass.new(1, 1))
      expect(runner.to_eq(true){true}).to have_result_with_lhs_rhs(Result::Pass.new(true, true))
      expect(runner.to_eq(false){false}).to have_result_with_lhs_rhs(Result::Pass.new(false, false))
    end
  end

  describe "Runner#collections_to_eq" do
    let(:runner){ Runner.new }

    it "correctly compares collections" do
      expect(runner.collections_to_eq([1,2,3]){[1,2,3]}).to have_result_with_lhs_rhs(Result::Pass.new([1,2,3], [1,2,3]))
      expect(runner.collections_to_eq({:hello => "world"}){ {:hello => "world"} }).to have_result_with_lhs_rhs(Result::Pass.new({:hello => "world"}, {:hello => "world"}))
    end

    it "fails if a non-collection object is passed as the expected value" do
      expect(runner.collections_to_eq("string"){[1,2,3]}).to have_result_with_lhs_rhs(Result::Fail.new([1,2,3], "string", message: "#collections_to_eq only compares Array or Hash objects. 'string' is not a valid collection at this time" ))

    end

    it "fails if a non-collection object is returned from the execution as the actual value" do
      expect(runner.collections_to_eq([1,2,3]){"string"}).to have_result_with_lhs_rhs(Result::Fail.new("string", [1,2,3], message: "#collections_to_eq only compares Array or Hash objects. The evaluated result, 'string', is not a valid collection at this time." ))
    end
  end

  describe "Runner's test space" do
    let(:runner){ Runner.new }

    it "Adds a new test result in the test space" do
      runner.it("returns true"){ runner.to_eq(true){ true } }
      expect(runner.test_space.keys).to include "returns true"
      expect(runner.test_space["returns true"].first).to be_instance_of Result::Pass

      runner.it("fails to return true"){ runner.to_eq(true){ false } }
      expect(runner.test_space.keys).to include "fails to return true"
      expect(runner.test_space.length).to eq 2
      expect(runner.test_space["fails to return true"].first).to be_instance_of Result::Fail
    end
  end
end
