module AdventOfCode2021
  module Models
    class Tally
      attr_reader :list, :default

      def initialize(list, default = '0')
        @list = list
        @default = default
      end
  
      def tally
        @tally ||= list.tally
      end
  
      def draw?
        tally.values.uniq.count == 1
      end
  
      def most_frequent_value
        sorted_tally.last.first
      end
  
      def highest_occurrence
        sorted_tally.last.last
      end
      
      def least_frequent_value
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
