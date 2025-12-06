# frozen_string_literal: true
module Solvers
  # Problem:
  # Given a 2 dimensional rectangular array
  # with each element being numbers and the last row containing operations
  # Execute the operation on each column and sum the results
  class CephalopodMathSolver
    attr_reader :operation_matrix

    def initialize(input: "day6")
      # get each line and split them into single chars
    input = Helpers::InputParser.new(input: input)
                                .parse_data
                                .map { _1.split(" ") }
    # To make part1 easier, we ideally want to reverse the columns/rows
    # to have a matrix where each row contains the numbers and the operation
    @operation_matrix = ::Helpers::OperationMatrix.new(input)
    end

    def solve
      puts "parts1: #{solve_part1}" # is correct
      puts "parts2: #{solve_part2}" # is correct
    end

    def solve_part1
      operation_matrix.operate
    end

    def solve_part2(result = 0); end
  end
end
