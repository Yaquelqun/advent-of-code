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
      puts "parts2: #{solve_part2}" # 4624208190 is too high
    end

    def solve_part1
      pairs.last.area
    end

    # Idea is to go throug each pair and find the first one where all four corners are in the 
    # shape formed by linking all coordinates. Given that all adjacents coordinates are either
    # on the same column or line (i.e the form does not have diagonals), i'm going to 
    # postulate that a point is in the polygon if i can find 4 points loosely boxing in the one 
    # i'm looking at
    # :point-up: that was a false assumption because i could get a snake or a rope like figure
    # So not sure how to solve it smartly ^^"
    def solve_part2
      pairs.reverse.each do |pair_with_area|
        puts "################################################################"
        corner1, corner2 = pair_with_area.pair # The 2 points
        puts "considering rectangle caused by #{corner1.coordinates} and #{corner2.coordinates}"
        area = pair_with_area.area
        puts "area is #{area}"

        corner3 = Helpers::Point.new(corner1.x, corner2.y)
        corner4 = Helpers::Point.new(corner2.x, corner1.y)
        if corner3.is_in_shape?(tiles) && corner4.is_in_shape?(tiles)
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