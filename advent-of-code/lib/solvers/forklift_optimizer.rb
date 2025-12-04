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
                                    .map { _1.split('') }
    end

    def solve
      puts "parts1: #{solve_part1}" # 1604 is correct
      # puts "parts2: #{solve_part2}" # 172681562473501 is correct
    end

    def solve_part1()
      result = 0
      grid.each_with_index do |row, row_num|
        row.each_with_index do |element, col_num|
          result += 1 if forkliftable?(element, row_num, col_num)
        end
      end
      result
    end

    def solve_part2()
    end

    private
    def forkliftable?(element, row_num, col_num)
      return false unless element == "@"
      surrounding_weight(row_num, col_num) <= 4
    end

    def surrounding_weight(row_num, col_num)
      weight = 0
      col_range = immediate_neighbors(col_num)
      grid[immediate_neighbors(row_num)].each do |row|
        row[col_range].each do |element|
          weight += 1 if element == '@'
        end
      end
      weight
    end

    def immediate_neighbors(num)
        min = num.zero? ? 0 : num - 1
        max = num + 1
        Range.new(min, max)
    end
  end
end