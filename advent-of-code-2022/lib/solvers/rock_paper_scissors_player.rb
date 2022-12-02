require_relative "../helpers/input_parser"

module AdventOfCode2022
  module Solvers
    class RockPaperScissorsSolver

      def initialize
        @data = Helpers::InputParser.new(endpoint: "day2_input")
                                    .parse_data
                                    .map { _1.split(" ") }
      end

      def solve
        puts "applying strategy guide: #{solve_part1}" # Solution: 13809
        # puts " three highest calory count: #{sorted_calory_count[-3..].sum}" # Solution: 198041
      end

      private

      RPS_MATRIX = {
        "A" => { "X" => 4, "Y" => 8, "Z" => 3 },
        "B" => { "X" => 1, "Y" => 5, "Z" => 9 },
        "C" => { "X" => 7, "Y" => 2, "Z" => 6 }
      }.freeze

      def solve_part1
        @data.reduce(0) do |acc, play|
          them, me = play
          acc + RPS_MATRIX[them][me]
        end
      end
    end
  end
end
