# frozen_string_literal: true

module Helpers
  # parses the input from the puzzles
  class InputParser
     def initialize(input:)
      @endpoint = input
    end

    def parse_data
      # return input.map(&:chomp) if 
      byebug
      file = File.open("#{__dir__}/../../inputs/#{endpoint}")
      file.readlines.map(&:chomp)
    end

    private

    attr_reader :endpoint
  end
end
