# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2021
  module Solvers
    # decodes submarine's report
    class DiagnosticReader

      def initialize
        @data = Helpers::InputParser.new(endpoint: "day3_input").parse_data
        @number_length = @data.first.length
      end

      def solve
        puts "gamma * epsilon rates = #{part1_solution}" # Solution: 
        # puts "depth * horizontal position = #{read_instructions(instructions_set: UPDATED_INSTRUCTIONS)}" # Solution: 
      end

      private

      attr_reader :data, :number_length

      def part1_solution
        gamma = []
        epsilon = []
        number_length.times do |index| # for each bit position in the binary number
          diagnostic_reading = @data.map { _1[index] } # pick that bit for each number
                               .tally # count the number of appeareances of 1 and 0
                               .sort_by(&:last) # sort by appearances
                               .map(&:first) # take the value of the bit
          gamma << diagnostic_reading.last
          epsilon << diagnostic_reading.first
        end

        gamma.join.to_i(2) * epsilon.join.to_i(2)
      end
    end
  end
end
