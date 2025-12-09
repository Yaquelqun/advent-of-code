module Solvers
  # Problem: Given a list of 2 dimension coordinates, find the
  # 2 points that form the largest rectangle
  class TilesRedecorator
    attr_reader :placeholder

    def initialize(input: "day4")
      # get each line and split them into single chars
      @placeholder = Helpers::InputParser.new(input: input)
                                         .parse_data
    end

    def solve
      puts "parts1: #{solve_part1}" # is correct
      puts "parts2: #{solve_part2}" # is correct
    end

    def solve_part1(result = 0); end

    def solve_part2(result = 0); end
  end
end