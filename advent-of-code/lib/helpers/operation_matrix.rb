require 'matrix'

module Helpers
  # Helper class to contain both operations and numbers
  class OperationMatrix
    attr_reader :input, :numbers_matrix, :operations
    
    def initialize(input)
      @input = input
      @operations = input.last
    end

    def operate
      operations.map.with_index do |operation, index|
        numbers_matrix.row(index).to_a.reduce(operation.to_sym)
      end.sum
    end

    private
    # Heavy lifting method that builds a matrix from the array input 
    # and rotates it
    def numbers_matrix
      @numbers_matrix ||= begin
        rows = input[..-2] # exclude last line since that's the operations
               .map { _1.map(&:to_i) } # turn em all into integers
               .map(&:reverse) # to make sure we rotate in the right direction
        # Now that we have rows, we can feed them all as columns
        # of the matrix, effectively rotating it 90 degrees
        result = Matrix.columns(rows) 
      end 
    end
  end
end