# frozen_string_literal: true

module Helpers
  # Simple Junction box model
  class Point
    attr_reader :x, :y, :z
    attr_accessor :circuit

    # rubocop:disable Naming/MethodParameterName
    def initialize(x = 0, y = 0, z = 0)
      @x = x.to_i
      @y = y.to_i
      @z = z.to_i
      @circuit = nil
    end
    # rubocop:enable Naming/MethodParameterName

    def coordinates
      [x, y, z]
    end

    def distance_to(other_box)
      Math.sqrt((other_box.x - x)**2 + (other_box.y - y)**2 + (other_box.z - z)**2)
    end

    def is_in_shape?(shape_corners)
      puts "is corner #{coordinates} in the shape ?"
      bottom_right = shape_corners.detect { _1.x >= x && _1.y >= y }
      return false unless bottom_right

      top_right = shape_corners.detect { _1.x >= x && _1.y <= y }
      return false unless top_right

      bottom_left = shape_corners.detect { _1.x <= x && _1.y >= y }
      return false unless bottom_left

      top_left = shape_corners.detect { _1.x <= x && _1.y <= y }
      return false unless top_left

      puts "all four corners found \n bottom_right: #{bottom_right.coordinates}, top_right: #{top_right.coordinates}, bottom_left: #{bottom_left.coordinates}, top_left: #{top_left.coordinates}"
      true
    end

    def reset_circuit
      @circuit = nil
    end
  end
end
