# frozen_string_literal: true
require 'matrix'

module AdventOfCode2021
  module Models
    # Represent a bingo card with the logic to tick a number and compute score
    class BingoCard
      attr_accessor :card

      def initialize(numbers)
        @card = Matrix.rows(numbers)
        @last_drawn_number = -1
      end

      def check_number(number)
        @last_drawn_number = number
        card.each_with_index do |value, row, column|
          card[row, column] = -1 if value == number
        end
      end

      def score
        raise 'wtf' if @last_drawn_number == -1
        card.row_vectors.map(&:to_a)
             .flatten
             .reduce(0) { |acc, number| number == -1 ? acc : acc + number } * @last_drawn_number
      end

      def won?
        winning_score = (card.row_count * -1)
        return true if card.row_vectors.any? { _1.to_a.sum == winning_score }
        return true if card.column_vectors.any? { _1.to_a.sum == winning_score }

        false
      end
    end
  end
end
