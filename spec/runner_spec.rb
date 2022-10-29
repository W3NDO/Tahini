require 'spec_helper'
require_relative '../lib/basic_runner'

RSpec.describe Runner do
  describe "Initializing a new Runner" do
    let(:runner){Runner.new}
    it "creates a new Runner object" do
      expect(runner.class).to eq Runner
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
      expect(runner.to_be(true){true }).to be true
    end

  end
end
