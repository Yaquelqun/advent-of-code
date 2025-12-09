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
      pairs.last.area
    end

    # Idea is to go throug each pair and find the first one where all four corners are in the 
    # shape formed by linking all coordinates. Given that all adjacents coordinates are either
    # on the same column or line (i.e the form does not have diagonals), i'm going to 
    # postulate that a point is in the form if there are coordinates on the right, left, up and down of the point i'm looking at 
    def solve_part2
      pairs.reverse.each do |pair_with_area|
        corner1, corner2 = pair_with_area.pair # The 2 points
        area = pair_with_area.area

        corner3 = Helpers::Point.new(corner1.x, corner2.y)
        corner4 = Helpers::Point.new(corner1.y, corner2.x)
        if corner3.is_in_shape?(tiles) && corner4.is_in_shape?(tiles)
          byebug
          return area 
        end
      end
    end

    def pairs
      # Good thing is that i can reuse what i did yesterday, the largest
      # rectangle is caused by the 2 points furthest apart.
      @pairs ||= Helpers::Points::DistanceComputer.new(tiles, pairing_method: :area)
                                               .ordered_pairs
    end
  end
end