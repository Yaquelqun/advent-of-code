# frozen_string_literal: true

module Helpers
  # Simple Junction box model
  class JunctionBox
    attr_reader :x, :y, :z
    attr_accessor :circuit

    # rubocop:disable Naming/MethodParameterName
    def initialize(x, y, z)
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

    def reset_circuit
      @circuit = nil
    end
  end
end
