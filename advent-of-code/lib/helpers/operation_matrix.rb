require 'matrix'

module Helpers
  # Helper class to contain both operations and numbers
  class OperationMatrix
    attr_reader :read_input, :numbers_matrix, :operations, :number_reading_method
    
    def initialize(input:, number_reading_method:)
      @read_input = send("read_input_as_#{number_reading_method}", input)
      @operations = input.last.split(" ") # Operations are on the last line
      @number_reading_method = number_reading_method
    end

    def operate
      puts "resolving matrix #{numbers_matrix.inspect}"
      operations.map.with_index do |operation, index| #for each operation
        # get the former column now row
        matrix_row = numbers_matrix.row(index)
        
        # read the row depending on which species you are
        numbers = send("read_row_as_#{number_reading_method}", matrix_row.to_a)
        byebug
        # apply the operation to the entire row
        numbers.reduce(operation.to_sym)
      end.sum
    end

    private
    # Heavy lifting method that builds a matrix from the array input 
    # and rotates it
    def numbers_matrix
      @numbers_matrix ||= begin
        rows = read_input # exclude last line since that's the operations

        # Now that we have rows, we can feed them all as columns
        # of the matrix, effectively rotating it 90 degrees
        result = Matrix.columns(rows) 
      end 
    end

    # Human are simple, they just split per space
    def read_input_as_human(input)
      input.map { _1.split(" ") }
    end


    # Humans read each row by turning numbers into integers
    def read_row_as_human(row)
      row.map(&:to_i)
    end

    # Cephalopods are crazy 'cause they read vertically
    # therefore we need to pad the input to preserve
    # the alignment of the numbers in the string.
    # Thankfully, cephalopods also don't know about the number 0
    # so we can use that to pad the number
    def read_input_as_cephalopod(input)
      
    end

    # Cephalopods read number vertically
    # so we're gonna have to do our weird matrix rotation trick again
    def read_row_as_cephalopod(row)
      rows = row.map { _1.split('') } #isolate each number as strings
      # Problem is that numbers are different sizes but matrix require columns to
      # all have the same size
      max_row_length = rows.map(&:size).max
      rows = rows.map do |r|
        padding_length = max_row_length - r.length
        next r if padding_length.zero?
        r = Array.new(padding_length, nil) + r
      end

      # now that the rows are padded, we can rotate them
      rotation_matrix = Matrix.columns(rows)
      
      # Finally we need to turn each row into a number
      rotation_matrix.to_a.map { _1.compact.join.to_i }
    end
  end
end