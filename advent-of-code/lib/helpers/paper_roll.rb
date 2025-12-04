module Helpers
  class PaperRoll
    attr_reader :element, :row_num, :col_num, :grid
    def initialize(element, row_num, col_num, grid)
      @element = element
      @row_num = row_num
      @col_num = col_num
      @grid = grid
    end

    def forkliftable?
      return false unless element == "@"
      surrounding_weight <= 4
    end

    private
    def surrounding_weight
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