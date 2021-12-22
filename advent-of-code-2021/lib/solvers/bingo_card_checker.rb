# frozen_string_literal: true

require_relative '../helpers/input_parser'
require_relative '../models/bingo_card'

module AdventOfCode2021
  module Solvers
    # simulate bingo rounds
    class BingoCardChecker
      def initialize
        @data = Helpers::InputParser.new(endpoint: 'day4_input').parse_data
      end

      def solve
        puts "winning card score: #{part1_solution}" # Solution: 
        # puts " : #{part2_solution}" # Solution: 
      end

      private

      attr_reader :data, :number_length

      def part1_solution
        # correctly parse the input
        # generate bingo card
        # puts them in ractors
        # for each number in the drawn list
          # send the number to each ractor
          # if any of them is winning
            # return the scor
      end

      def part2_solution
      end
    end
  end
end
