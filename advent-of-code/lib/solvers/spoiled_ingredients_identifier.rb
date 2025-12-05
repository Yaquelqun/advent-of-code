# frozen_string_literal: true

require_relative "../monkey_patches/array" # Lol

module Solvers
  # Problem:
  class SpoiledIngredientsIdentifier
    attr_reader :ranges, :ingredient_ids

    def initialize(input: "day5")
      # get each line and split them into single chars
      input = Helpers::InputParser.new(input: input)
                                  .parse_data
                                  .split("") # Custom monkeypatched method to imitate string.split

      @ranges = compute_ranges(input.first)
      @ingredient_ids = input.last.map(&:to_i)
    end

    def solve
      puts "parts1: #{solve_part1}" # 520 is correct
      puts "parts2: #{solve_part2}" # is correct
    end

    def solve_part1(result = 0)
      ingredient_ids.each_with_index do |ingredient_id, index|
        puts "Treating ingredient #{index + 1}/#{ingredient_ids.count}"
        result += 1 if ranges.any? { _1.include? ingredient_id }
      end
      result
    end

    def solve_part2; end

    private

    def compute_ranges(input)
      input.map do |i|
        boundaries = i.split("-").map(&:to_i)
        Range.new(boundaries[0], boundaries[1])
      end
    end
  end
end
