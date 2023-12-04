# frozen_string_literal: true

require_relative "../models/scratchcard"

module Solvers
  class ScratchcardComputer
    attr_reader :scratchcards

    def initialize
      input = Helpers::InputParser.new(endpoint: "day4")
                                  .parse_data
      @scratchcards = input.map { Scratchcard.new(_1) }
    end

    def solve
      puts "part 1: #{scratchcards.map(&:score).sum}" # 20855
      puts "part 2: #{total_winnings}" # 5489600
    end

    def total_winnings
      remaining_cards = Hash.new(0)
      scratchcards.sort_by(&:id).each do |scratchcard|
        remaining_cards[scratchcard.id] += 1
        scratchcard.won_card_ids.each { remaining_cards[_1] += remaining_cards[scratchcard.id] }
      end

      remaining_cards.values.sum
    end
  end
end
