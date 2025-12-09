# frozen_string_literal: true

require "spec_helper"

RSpec.describe Solvers::TilesRedecorator do
  describe "#solve_part1" do
    subject { described_class.new(input:).solve_part1 }
    let(:input) { "day9_test" }

    it "returns the right result" do
      expect(subject).to eql 50
    end
  end

  describe "#solve_part2" do
    subject { described_class.new(input:).solve_part2 }
    let(:input) { "day9_test" }

    it "returns the right result" do
      expect(subject).to eql 24
    end
  end
end
