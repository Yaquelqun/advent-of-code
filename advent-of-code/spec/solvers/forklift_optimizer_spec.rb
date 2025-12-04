# frozen_string_literal: true

require "spec_helper"

RSpec.describe Solvers::ForkliftOptimizer do
  describe "#solve_part1" do
    subject { described_class.new(input:).solve_part1 }
    let(:input) { "day4_test" }

    it "returns the right result" do
      expect(subject).to eql 13
    end
  end

  describe "#solve_part2" do
    subject { described_class.new(input:).solve_part2 }
    let(:input) { "day4_test" }

    it "returns the right result" do
      expect(subject).to eql 'done2'
    end
  end
end
