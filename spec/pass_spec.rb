require 'spec_helper'
require_relative '../lib/result'

RSpec.describe Result::Pass do
  describe "Initializing a new Pass Object" do
    let(:pass){ Result::Pass.new(true, true) }
    let(:invalid_pass){ nil  }

    it "creates a new valid Pass object" do
      expect(pass).to be_instance_of Result::Pass
      expect(pass.lhs).to eq true
      expect(pass.rhs).to eq true
    end

    it "ensures that a pass object inherits from the Result class" do
      expect(pass.class.ancestors[1].name).to eq "Result::Result"
    end

    it "raises a validity error if lhs and rhs values do not match" do
      expect{ invalid_pass = Result::Pass.new(true, "true")  }.to raise_error ArgumentError
    end
  end
end
