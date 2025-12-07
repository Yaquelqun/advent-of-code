# frozen_string_literal: true

require "spec_helper"

RSpec.describe Solvers::TachyonBeamSimulator do
  describe "#solve_part1" do
    subject { described_class.new(input:).solve_part1 }
    let(:input) { "day7_test" }

    it "returns the right result" do
      expect(subject).to eql 21
    end
  end

  describe "#solve_part2" do
    subject { described_class.new(input:).solve_part2 }
    let(:input) { "day7_test" }

    it "returns the right result" do
      expect(subject).to eql 40
    end
  end
end
