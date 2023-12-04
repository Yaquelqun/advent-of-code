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
      puts "part 2: #{2}" # 
    end
  end
end