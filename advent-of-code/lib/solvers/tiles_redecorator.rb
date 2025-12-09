module Solvers
  # Problem: Given a list of 2 dimension coordinates, find the
  # 2 points that form the largest rectangle
  class TilesRedecorator
    attr_reader :tiles

    def initialize(input: "day9")
      @tiles = Helpers::InputParser.new(input: input)
                                         .parse_data
                                         .map { _1.split(",") }
                                         .map { Helpers::Point.new(*_1) }
    end

    def solve
      puts "parts1: #{solve_part1}" # 4765757080 is correct
      puts "parts2: #{solve_part2}" # is correct
    end

    def solve_part1
      # Good thing is that i can reuse what i did yesterday, the largest
      # rectangle is caused by the 2 points furthest apart.
      pairs = Helpers::Points::DistanceComputer.new(tiles, pairing_method: :area)
                                               .ordered_pairs
      pairs.last.area
    end

    def solve_part2(result = 0); end
  end
end