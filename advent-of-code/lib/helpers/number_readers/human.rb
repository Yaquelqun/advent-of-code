module Helpers
  module NumberReaders
    # Human number reader class.
    # Contains enough logic to parse numbers
    module Human
      # Given an array of strings with number,
      # humans isolate each number by looking at
      # digits between the spaces
      def self.read_input(input)
        input.map { _1.split(" ") }
      end
      # Humans read each row by turning numbers into integers
      def self.read_row(row)
        row.map(&:to_i)
      end
    end
  end
end
