# frozen_string_literal: true

module AdventOfCode2021
  module Models
    # represent one line build from 2 coordinates
    class Line
      attr_accessor :starting_row, :target_row, :starting_column,
                    :target_column, :row_direction, :column_direction, :current_row, :current_column

      def initialize(coordinates)
        @starting_row = coordinates[0][0]
        @target_row = coordinates[1][0]
        @starting_column = coordinates[0][1]
        @target_column = coordinates[1][1]
        compute_directions
        set_pointer
      end

      def compute_directions
        @row_direction = target_row <=> starting_row
        @column_direction = target_column <=> starting_column
      end

      def set_pointer
        @current_row = starting_row
        @current_column = starting_column
      end

      def pointer
        [current_row, current_column]
      end

      def move_pointer
        @current_row += row_direction
        @current_column += column_direction
      end

      def processed?
        current_row == target_row && current_column == target_column
      end
    end
  end
end
