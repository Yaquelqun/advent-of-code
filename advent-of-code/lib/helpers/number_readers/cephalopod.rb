module Helpers
  module NumberReaders
    # bloob bloob blub blub bloob
    module Cephalopod

    # Cephalopods are crazy 'cause they read vertically
    # therefore we need to pad the input to preserve
    # the alignment of the numbers in the string.
    # Thankfully, cephalopods also don't know about the number 0
    # so we can use that to pad the number
    def self.read_input(input)
      puts "input= #{input.inspect}"
      # Could probably be a regex but i'm too lazy to dig in there
      result = input.map { _1.split('') } # separate each character of each row
      result.map! do |row|
        row.map.with_index do |element, col| #for each element
          next element unless element == ' ' # numbers are handled as usual
          # If the element is a space, we replace it by 0 if there's another number
          # in the column
          element = 0 if input.any? { |row| row[col] != ' '}
          element
        end
      end
      result.map(&:join).map{ _1.split(' ') }
    end

    # Cephalopods read number vertically
    # so we're gonna have to do our weird matrix rotation trick again
    def self.read_row(row)
      rows = row.map { _1.split('') } #isolate each number as strings

      rotation_matrix = Matrix.columns(rows)
      # Finally we need to turn each row into a number
      # while ignoring 0 since cephalopods dunno about it
      rotation_matrix.to_a.map do |string_digits| 
        string_digits.reject { |string_digit| string_digit == '0' }
        .join
        .to_i
      end
    end
    end
  end
end