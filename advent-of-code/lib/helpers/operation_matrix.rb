require 'matrix'

module Helpers
  # Helper class to contain both operations and numbers
  class OperationMatrix
    attr_reader :input, :numbers_matrix, :operations, :number_reading_method
    
    def initialize(input:, number_reading_method:)
      @input = input
      @operations = input.last
      @number_reading_method = number_reading_method
    end

    def operate
      puts "resolving matrix #{numbers_matrix.inspect}"
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
               .map do |row| # Apparently cephalopods and humans don't read numbers the same way
                  send("read_row_as_#{number_reading_method}", row)
               end
        # Now that we have rows, we can feed them all as columns
        # of the matrix, effectively rotating it 90 degrees
        result = Matrix.columns(rows) 
      end 
    end

    # Humans read each row by turning numbers into integers
    def read_row_as_human(row)
      row.map(&:to_i)
    end
  end
end