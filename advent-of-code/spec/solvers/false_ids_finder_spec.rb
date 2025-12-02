require 'spec_helper'

RSpec.describe Solvers::FalseIdsFinder do
  describe "#solve_part1" do
    subject { described_class.new(input:).solve_part1 }
    let(:input) { 'day2_test' }

    it 'returns the right result' do
      expect(subject).to eql 1227775554
    end
  end
  
  xdescribe "#solve_part2" do
    subject { described_class.new(input:).solve_part2 }
    let(:input) { 'day2_test' }

    it 'returns the right result' do
      expect(subject).to eql 6
    end
  end
  
end