require 'spec_helper'

RSpec.describe Solvers::TemplateSolver do
  describe "#solve_part1" do
    subject { described_class.new(endpoint:).solve_part1 }
    let(:endpoint) { 'template_input' }

    it 'returns the right result' do
      expect(subject).to eql 'done1'
    end
  end
  
  describe "#solve_part2" do
    subject { described_class.new(endpoint:).solve_part2 }
    let(:endpoint) { 'template_input' }

    it 'returns the right result' do
      expect(subject).to eql 'done2'
    end
  end
  
end