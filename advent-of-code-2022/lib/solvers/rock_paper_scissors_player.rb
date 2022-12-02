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
        puts "applying strategy guide: #{apply_matrix(RPS_MATRIX_1)}" # Solution: 13809
        puts "applying result first strategy: #{apply_matrix(RPS_MATRIX_2)}" # Solution: 198041
      end

      private

      RPS_MATRIX_1 = {
        "A" => { "X" => 4, "Y" => 8, "Z" => 3 },
        "B" => { "X" => 1, "Y" => 5, "Z" => 9 },
        "C" => { "X" => 7, "Y" => 2, "Z" => 6 }
      }.freeze

      RPS_MATRIX_2 = {
        "A" => { "X" => 3, "Y" => 4, "Z" => 8 },
        "B" => { "X" => 1, "Y" => 5, "Z" => 9 },
        "C" => { "X" => 2, "Y" => 6, "Z" => 7 }
      }.freeze

      def apply_matrix(solution_matrix)
        @data.reduce(0) do |acc, play|
          them, me = play
          acc + solution_matrix[them][me]
        end
      end
    end
  end
end
