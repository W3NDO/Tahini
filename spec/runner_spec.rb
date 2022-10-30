require 'spec_helper'
require_relative '../lib/basic_runner'
require_relative '../lib/fail'

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
    end
  end

  describe "Runner#to_be" do
    let(:runner){Runner.new}

    it "fails if a boolean value is not provided" do
      expect{ runner.to_be("string"){true} }.to raise_error ArgumentError
    end

    it "accepts a string and a boolean and compares against the boolean" do
      expect(runner.to_be(true){ false }).to be_instance_of Fail
      expect(runner.to_be(true){ true }).to be_instance_of Pass
    end
  end

  describe "Runner#to_eq" do
    let(:runner){Runner.new}

    it "returns a fail if the classes of the expected and actual do not match" do
      expect(runner.to_eq([1,2,3]){"1,2,3"}).to be_instance_of Fail
    end

    it "correctly compares strings, booleans, numbers" do
      expect(runner.to_eq([1,2,3]){[1,2,3]}).to be_instance_of Pass
      expect(runner.to_eq("Hello world"){"Hello world"}).to be_instance_of Pass
      expect(runner.to_eq(1){1}).to be_instance_of Pass
      expect(runner.to_eq(true){true}).to be_instance_of Pass
      expect(runner.to_eq(false){false}).to be_instance_of Pass
    end

    xit "correctly compares collections" do
    end
  end
end
