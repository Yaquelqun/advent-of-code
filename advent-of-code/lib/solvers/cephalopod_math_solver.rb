# frozen_string_literal: true
module Solvers
  # Problem:
  # Given a 2 dimensional rectangular array
  # with each element being numbers and the last row containing operations
  # Execute the operation on each column and sum the results
  class CephalopodMathSolver
    attr_reader :input

    def initialize(input: "day6")
      # get each line
    @input = Helpers::InputParser.new(input: input)
                                .parse_data
    
    end

    def solve
      puts "parts1: #{solve_part1}" # 4805473544166 is correct
      puts "parts2: #{solve_part2}" # is correct
    end

    def solve_part1
      ::Helpers::OperationMatrix
      .new(input: input, reader: Helpers::NumberReaders::Human)
      .operate
    end

    def solve_part2
      ::Helpers::OperationMatrix
      .new(input: input, reader: Helpers::NumberReaders::Cephalopod)
      .operate
    end
  end
end
