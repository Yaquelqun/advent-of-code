# frozen_string_literal: true

require "spec_helper"

RSpec.describe Solvers::JolterComputer do
  describe "#solve_part1" do
    subject { described_class.new(input:).solve_part1 }
    let(:input) { "day3_test" }

    it "returns the right result" do
      expect(subject).to eql 357
    end
  end

  xdescribe "#solve_part2" do
    subject { described_class.new(input:).solve_part2 }
    let(:input) { "day3_test" }

    it "returns the right result" do
      expect(subject).to eql 3121910778619
    end
  end
end
