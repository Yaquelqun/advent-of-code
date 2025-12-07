# frozen_string_literal: true

module Helpers
  class TachyonGrid
    attr_reader :rows, :split_count, :input_grid

    def initialize(input_grid:)
      @input_grid = input_grid
      @split_count = 0
    end

    def simulate
      display
      self
    end

    private

    def display
      rows.each(&:display)
    end

    def rows
      @rows ||= begin
        input_grid.map do |row|
          Helpers::TachyonRow.new(input: row)
        end
      end
    end
  end
end
