require 'spec_helper'

RSpec.describe Solvers::SafePasswordDecryptor do
  describe "#solve_part1" do
    subject { described_class.new(input:).solve_part1 }
    let(:input) { 'day1_test' }

    it 'returns the right result' do
      expect(subject).to eql 3
    end
  end
end