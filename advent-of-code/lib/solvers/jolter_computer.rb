module Solvers
  # Problem
  # Given several lines of digits,
  # make the highest 2 digits number where the first
  # digits is before the second one
  class JolterComputer
     attr_reader :ranges

    def initialize(input: "day3")
      @ranges = Helpers::InputParser.new(input: input)
                                    .parse_data
    end

    def solve
      puts "parts1: #{solve_part1}" #  is correct
      puts "parts2: #{solve_part2}" #  is correct
    end

    def solve_part1()
      "done1"
    end

    def solve_part2()
      "done2"
    end
  end
end