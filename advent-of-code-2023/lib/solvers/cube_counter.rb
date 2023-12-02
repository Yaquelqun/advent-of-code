# frozen_string_literal: true

require_relative "../models/cube_game"

module Solvers
  class CubeCounter
    attr_reader :games

    def initialize
      @games = Helpers::InputParser.new(endpoint: "day2")
                                   .parse_data
                                   .map { CubeGame.new(_1) }
    end

    def solve
      puts "part 1: #{possible_games(red: 12, green: 13, blue: 14).map(&:id).sum}" # 2204
      puts "part 2: #{games.sum(&:power)}" # 71036
    end

    private

    def possible_games(red:, green:, blue:)
      games.select { _1.max_red <= red && _1.max_green <= green && _1.max_blue <= blue }
    end
  end
end
