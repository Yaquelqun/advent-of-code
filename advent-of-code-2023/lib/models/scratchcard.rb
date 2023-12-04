# frozen_string_literal: true

class Scratchcard
  attr_reader :id, :targets, :scratched

  def initialize(input_string)
    @id = input_string.match(/Card *(\d+):/)[1].to_i
    numbers = input_string.split(":").last.split("|")
    @targets = numbers[0].split.map(&:to_i)
    @scratched = numbers[1].split.map(&:to_i)
  end

  def score
    winning_numbers_count = (targets & scratched).length
    return 0 if winning_numbers_count.zero?

    2.pow(winning_numbers_count - 1)
  end
end
