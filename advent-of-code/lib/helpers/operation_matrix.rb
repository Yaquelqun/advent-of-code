# frozen_string_literal: true

require "matrix"

module Helpers
  # Helper class to contain both operations and numbers
  class OperationMatrix
    attr_reader :input, :reader, :numbers_matrix, :operations

    def initialize(input:, reader:)
      @input = input
      @reader = reader
      @operations = input.last.split(" ") # Operations are on the last line
    end

    def operate
      operations.map.with_index do |operation, index| # for each operation
        # get the former column now row
        matrix_row = numbers_matrix.row(index)

        # read the row depending on which species you are
        numbers = reader.read_row(matrix_row.to_a)

        # apply the operation to the entire row
        numbers.reduce(operation.to_sym)
      end.sum
    end

    private

    # Heavy lifting method that builds a matrix from the array input
    # and rotates it
    def numbers_matrix
      @numbers_matrix ||= begin
        rows = reader.read_input(input[..-2]) # exclude last line since that's the operations
        # Now that we have rows, we can feed them all as columns
        # of the matrix, effectively rotating it 90 degrees
        Matrix.columns(rows)
      end
    end
  end
end
