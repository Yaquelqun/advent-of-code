module AdventOfCode2021
  module Models
    class SubmarinePosition
      attr_accessor :horizontal, :depth, :aim

      def initialize
        @horizontal = 0
        @depth = 0
        @aim = 0
      end

      def reset
        initialize
      end

      def multiply_coordinates
        @horizontal * @depth
      end

      def increase_depth(amount)
        @depth += amount
      end

      def decrease_depth(amount)
        @depth -= amount
      end

      def increase_aim(amount)
        @aim += amount
      end

      def decrease_aim(amount)
        @aim -= amount
      end

      def move_forward(amount)
        @horizontal += amount
        @depth += (@aim * amount)
      end
    end
  end
end
