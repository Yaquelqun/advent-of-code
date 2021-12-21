# frozen_string_literal: true

module AdventOfCode2021
  module Models
    # Useful methods around tallies
    class Tally
      attr_reader :list

      def initialize(list)
        @list = list
      end

      def tally
        @tally ||= list.tally
      end

      def draw?
        tally.values.uniq.count == 1
      end

      def most_frequent_value
        return "1" if draw?

        sorted_tally.last.first
      end

      def highest_occurrence
        sorted_tally.last.last
      end

      def least_frequent_value
        return "0" if draw?

        sorted_tally.first.first
      end

      def lowest_occurrence
        sorted_tally.first.last
      end

      def sorted_tally
        @sorted_tally ||= tally.sort_by(&:last)
      end
    end
  end
end
