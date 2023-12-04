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
    return 0 if winnings.zero?

    2.pow(winnings - 1)
  end

  def won_card_ids
    @won_card_ids ||= (id..(id + winnings)).to_a - [id]
  end

  def winnings
    @winnings ||= (targets & scratched).length
  end
end
