# frozen_string_literal: true

require "spec_helper"

RSpec.describe Solvers::CephalopodMathSolver do
  describe "#solve_part1" do
    subject { described_class.new(input:).solve_part1 }
    let(:input) { "day6_test" }

    it "returns the right result" do
      expect(subject).to eql 4_277_556
    end
  end

  describe "#solve_part2" do
    subject { described_class.new(input:).solve_part2 }
    let(:input) { "day6_test" }

    it "returns the right result" do
      expect(subject).to eql 3_263_827
    end
  end
end
