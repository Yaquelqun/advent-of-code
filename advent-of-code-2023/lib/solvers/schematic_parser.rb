# frozen_string_literal: true

require_relative "../models/schematic_part"

module Solvers
  class SchematicParser
    attr_reader :schematic, :parts

    def initialize
      @schematic = Helpers::InputParser.new(endpoint: "day3")
                                       .parse_data
                                       .map { _1.split("") }
      @parts = []
      generate_parts
    end

    def solve
      puts "part 1: #{symbol_adjacent_parts_sum}" # 559667
      puts "part 2: #{gear_ratio_sum}" # 86841457
    end

    private

    def symbol_adjacent_parts_sum
      result = 0

      symbols.each do |symbol|
        integers = parts.select { _1.type == :integer && _1.adjacent_to?(*symbol.positions[0]) }
        result += integers.map(&:value).sum
      end

      result
    end

    def gear_ratio_sum
      result = 0

      symbols.each do |symbol|
        next unless symbol.gear_ratio?

        integers = parts.select { _1.type == :integer && _1.adjacent_to?(*symbol.positions[0]) }
        next unless integers.length == 2

        result += integers.map(&:value).reduce(&:*)
      end

      result
    end

    def generate_parts
      x = y = 0
      max_y = schematic.size

      x, y = generate_part(x, y) while y < max_y
    end

    def generate_part(x, y)
      case schematic.dig(y, x)
      when /\d/
        x = parse_integer_at(x, y)
      when "."
        x += 1
      when nil
        x = 0
        y += 1
      else
        x = parse_symbol_at(x, y)
      end
      [x, y]
    end

    def parse_symbol_at(x, y)
      @parts << SchematicPart.new(value: schematic.dig(y, x), type: :symbol, positions: [[x, y]])
      x + 1
    end

    def parse_integer_at(x, y)
      result = []
      positions = []
      while schematic.dig(y, x)&.match?(/\d/)
        result << schematic.dig(y, x)
        positions << [x, y]
        x += 1
      end
      @parts << SchematicPart.new(value: result.join.to_i, type: :integer, positions: positions)
      x
    end

    def symbols
      @symbols ||= parts.select { _1.type == :symbol }
    end
  end
end
