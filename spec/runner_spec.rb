require 'spec_helper'
require_relative '../lib/basic_runner'

RSpec.describe Runner do
  describe "Initializing a new Runner" do
    let(:runner){Runner.new}
    it "creates a new Runner object" do
      expect(runner.class).to eq Runner
    end
  end

  describe "Runner#test" do
    it "accepts "
  end
end