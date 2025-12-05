# frozen_string_literal: true

# Monkey patched method to be able to split an array
# into sub arrays the same way String.split does
# Don't do this for real :p
class Array
  def split(value, result = [], sub_array = [])
    each do |element|
      if element == value
        result << sub_array
        sub_array = []
      else
        sub_array << element
      end
    end
    result << sub_array
    result.compact
  end
end
