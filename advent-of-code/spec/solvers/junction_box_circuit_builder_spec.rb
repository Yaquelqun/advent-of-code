# frozen_string_literal: true

require "spec_helper"

RSpec.describe Solvers::JunctionBoxCircuitBuilder do
  describe "#solve_part1" do
    subject { described_class.new(input:).solve_part1 }
    let(:input) { "day8_test" }

    it "returns the right result" do
      expect(subject).to eql 40
    end
  end

  describe "#solve_part2" do
    subject { described_class.new(input:).solve_part2 }
    let(:input) { "day8_test" }

    it "returns the right result" do
      expect(subject).to eql 'done2'
    end
  end
end
