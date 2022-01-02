# frozen_string_literal: true

require "matrix"

module AdventOfCode2021
  module Models
    # Represents a page with dots on it
    class DottedPage
      attr_accessor :page

      def initialize(width:, height:)
        @page = Matrix.build(height + 1, width + 1) { false }
      end

      def add_dots(dot_coordinates)
        dot_coordinates.each { page[_2, _1] = true }
      end

      def fold_along_x(folding_index)
        # separate matrix into the new page and the to be folded one depending on both argument
        to_be_folded = page.minor(0..-1, (folding_index + 1)..-1)
        @page = page.minor(0..-1, 0..(folding_index - 1))

        # depending on dimension, add to be folded matrix to the nth last rows or column of the new page
        to_be_folded.each_with_index do |value, y, x|
          page[y, (-1 - x)] ||= value
        end
      end

      def fold_along_y(folding_index)
        # separate matrix into the new page and the to be folded one depending on both argument
        to_be_folded = page.minor((folding_index + 1)..-1, 0..-1)
        @page = page.minor(0..(folding_index - 1), 0..-1)

        # depending on dimension, add to be folded matrix to the nth last rows or column of the new page
        to_be_folded.each_with_index do |value, y, x|
          page[(-1 - y), x] ||= value
        end
      end

      def dot_count
        page.count { _1 }
      end

      def display_result
        pp page.map { _1 ? "#" : "." }.to_a.map(&:join)
        nil
      end
    end
  end
end
