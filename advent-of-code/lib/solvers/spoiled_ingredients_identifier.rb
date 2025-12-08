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
      puts "parts2: #{solve_part2}" # 347338785050515 is too correct
    end

    def solve_part1(result = 0)
      ingredient_ids.each_with_index do |ingredient_id, _index|
        result += 1 if ranges.any? { _1.include? ingredient_id }
      end
      result
    end

    def solve_part2(_all_numbers = [])
      reduced_ranges = reduce_ranges(ranges.dup) # Duplicating 'cause i'm gonna mutate the input
      reduced_ranges.sum(&:size)
    end

    private

    def compute_ranges(input)
      input.map do |i|
        boundaries = i.split("-").map(&:to_i)
        Range.new(boundaries[0], boundaries[1])
      end
    end

    # Since part 2 is too machine intensive,
    # we need to merge the ranges first to make sure
    # that the list only contains exclusive ranges
    # to make their size easier to compute
    def reduce_ranges(unresolved_ranges, result = [])
      unresolved_ranges.sort_by!(&:first)
      until unresolved_ranges.empty?
        range = unresolved_ranges.first
        # get all ranges where one of the boundaries is in our range (this will get our current range)
        conflicted_ranges = unresolved_ranges.select do
          _1.min.between?(range.min, range.max) || _1.max.between?(range.min, range.max)
        end

        if conflicted_ranges == [range] # If no conflict
          result << range
          unresolved_ranges.shift
          next
        end

        extended_range = build_extended_range(conflicted_ranges)
        # Now the only thing left to do is to remove the conflicted ranges (and us)
        # from the array now that they have been resolved
        conflicted_ranges.each { unresolved_ranges.delete(_1) }
        # And add the extended range to the unresolved_ranges to be further refined
        unresolved_ranges << extended_range
      end
      result
    end

    # Helper method to check if the results coherents
    def check_ranges(input)
      input.each do |range|
        conflicted_ranges = input.select do
          _1.min.between?(range.min, range.max) || _1.max.between?(range.min, range.max)
        end
        if conflicted_ranges.count > 1
          raise "conflict found ! #{range} is conflicting with #{conflicted_ranges.inspect}"
        end
      end
    end

    def build_extended_range(input)
      # The extented range is now the collective min/max of the conflicted_ranges
      extended_range_min = input.map(&:min).min
      extended_range_max = input.map(&:max).max
      Range.new(extended_range_min, extended_range_max)
    end
  end
end
