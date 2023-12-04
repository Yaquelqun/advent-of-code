# frozen_string_literal: true

class SchematicPart
  attr_reader :value, :positions, :type

  def initialize(value:, positions:, type:)
    @value = value
    @positions = positions
    @type = type
  end

  def is_gear_ratio?
    value == "*"
  end

  def adjacent_to?(x, y)
    positions.any? { (x - _1).abs <= 1 && (y - _2).abs <= 1 }
  end
end
