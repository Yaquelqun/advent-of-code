# frozen_string_literal: true

require "spec_helper"

RSpec.describe Solvers::SpoiledIngredientsIdentifier do
  describe "#solve_part1" do
    subject { described_class.new(input:).solve_part1 }
    let(:input) { "day5_test" }

    it "returns the right result" do
      expect(subject).to eql 3
    end
  end

  describe "#solve_part2" do
    subject { described_class.new(input:).solve_part2 }
    let(:input) { "day5_test" }

    it "returns the right result" do
      expect(subject).to eql 'done2'
    end
  end
end
