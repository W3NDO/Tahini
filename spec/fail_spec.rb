require 'spec_helper'
require_relative '../lib/result'

RSpec.describe Result::Fail do
  describe "Creating a new Fail object" do
    let(:fail_object){ Result::Fail.new("12", 12) }
    let(:messaged_fail_object){ Result::Fail.new("12", 12, message: "type mismatch") }
    let(:invalid_fail_object){nil}

    it "Initializes a new fail object without a message" do
      expect(fail_object).to be_instance_of Result::Fail
    end

    it "ensures that a fail object inherits from the Result class" do
      expect(fail_object.class.ancestors[1].name).to eq "Result::Result"
    end

    it "Initializes a new fail object with a message" do
      expect(messaged_fail_object).to be_instance_of Result::Fail
      expect(messaged_fail_object.message).to eq("type mismatch")
    end

    it "fails if the rhs value is equal to the left hand side value" do
      expect{ invalid_fail_object = Result::Fail.new(true, true) }.to raise_error ArgumentError
    end
  end
end
