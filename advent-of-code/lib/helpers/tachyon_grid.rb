# frozen_string_literal: true

module Helpers
  class TachyonGrid
    attr_reader :rows, :split_count, :input_grid

    def initialize(input_grid:)
      @input_grid = input_grid
      @split_count = 0
    end

    def simulate
      self
    end
  end
end
