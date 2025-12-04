# frozen_string_literal: true

module Solvers
  # Problem:
  # Given a grid of '@' and '.', find every @
  # that's surrounded by less that 4 @
  class ForkliftOptimizer
    attr_reader :grid

    def initialize(input: "day4")
      # get each line and split them into single chars
      @grid = Helpers::InputParser.new(input: input)
                                  .parse_data
                                  .map { _1.split("") }
    end

    def solve
      puts "parts1: #{solve_part1}" # 1604 is correct
      puts "parts2: #{solve_part2}" # 9397 is correct
    end

    # Part 1 is easy since we simply iterate over every element
    def solve_part1(result = 0)
      grid.each_with_index do |row, row_num|
        row.each_with_index do |element, col_num|
          result += 1 if forkliftable?(element, row_num, col_num)
        end
      end
      result
    end

    # Part two is the same logic as part one, but once we're done
    # we try with the resulting grid until there's nothing to remove
    # Could probably save myself a couple of loops by putting . in the grid
    # while i remove the roll, but no time to test it :p
    def solve_part2(result = 0)
      loop do
        liftable_coordinates = []
        grid.each_with_index do |row, row_num|
          row.each_with_index do |element, col_num|
            next unless forkliftable?(element, row_num, col_num)

            liftable_coordinates << [row_num, col_num]
          end
        end
        result += liftable_coordinates.count
        liftable_coordinates.each do |row_num, col_num|
          @grid[row_num][col_num] = "."
        end
        break if liftable_coordinates.empty?
      end
      result
    end

    private

    # check yo neighbours method
    def forkliftable?(element, row_num, col_num)
      return false unless element == "@"

      surrounding_weight(row_num, col_num) <= 4
    end

    # Heavy method to get the surroundings element and check them all
    def surrounding_weight(row_num, col_num)
      weight = 0
      col_range = immediate_neighbors(col_num)
      grid[immediate_neighbors(row_num)].each do |row|
        row[col_range].each do |element|
          weight += 1 if element == "@"
        end
      end
      weight
    end

    # Kinda smartass here by generating endless range
    #  for columns and row 0, not sure i need it :p
    def immediate_neighbors(num)
      min = num.zero? ? 0 : num - 1
      max = num + 1
      Range.new(min, max)
    end
  end
end
