module Solvers
  # Problem:
  # Given a grid of '@' and '.', find every @
  # that's surrounded by less that 4 @
  class ForkliftOptimizer
    attr_reader :grid

    def initialize(input: "day3")
      # get each line and split them into single chars
      @grid = Helpers::InputParser.new(input: input)
                                    .parse_data
                                    .map { _1.split('') }
    end

    def solve
      puts "parts1: #{solve_part1}" # 17412 is correct
      # puts "parts2: #{solve_part2}" # 172681562473501 is correct
    end

    def solve_part1()
      @rolls = []
      grid.each_with_index do |row, row_num|
        row.each_with_index do |element, col_num|
          @rolls << ::Helpers::PaperRoll.new(element, row_num, col_num, grid)
        end
      end
      @rolls.select(&:forkliftable?).count
    end

    def solve_part2()
    end
  end
end