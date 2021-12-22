# frozen_string_literal: true

require_relative "../helpers/input_parser"
require_relative "../models/bingo_card"

module AdventOfCode2021
  module Solvers
    # simulate bingo rounds
    class BingoCardChecker
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day4_input").parse_data
      end

      def solve
        puts "first card score: #{part1_solution}" # Solution: 21607
        puts "last card score: #{part2_solution}" # Solution: 19012
      end

      private

      attr_reader :data

      def part1_solution
        score_list.first
      end

      def part2_solution
        score_list.last
      end

      def score_list
        @score_list ||= begin
          input_list, bingo_inputs = parse_input_data
          bingo_ractors = generate_ractors(bingo_inputs.map { Models::BingoCard.new(_1) })
          play_all_rounds(input_list, bingo_ractors)
        end
      end

      def parse_input_data
        input_list = data.first.split(",").map(&:to_i)
        bingo_inputs = []
        current_bingo_input = []
        data[2..].each do |input_line|
          current_bingo_input << input_line.split.map(&:to_i) and next unless input_line == ""

          bingo_inputs << current_bingo_input
          current_bingo_input = []
        end

        [input_list, bingo_inputs]
      end

      # rubocop:disable Metrics/MethodLength
      def generate_ractors(bingo_cards)
        bingo_cards.map do |bingo_card|
          Ractor.new(bingo_card) do |ractor_card|
            loop do
              case Ractor.receive
              in { action: :mark_number, number: }
                ractor_card.check_number(number)
              in { action: :check_winning }
                Ractor.yield(ractor_card.won?)
              in { action: :score }
                Ractor.yield(ractor_card.score)
              end
            end
          end
        end
      end
      # rubocop:enable Metrics/MethodLength

      def play_all_rounds(input_list, bingo_ractors)
        score_list = []
        input_list.each do |drawn_number|
          play_round(bingo_ractors, drawn_number).each do |winning_ractor, _|
            score_list << winning_ractor.send({ action: :score }).take
            bingo_ractors -= [winning_ractor]
          end
        end

        score_list
      end

      # plays round and return victors
      def play_round(bingo_ractors, drawn_number)
        bingo_ractors.map { _1.send({ action: :mark_number, number: drawn_number }) }
        bingo_ractors.map { _1.send({ action: :check_winning }) }.map{ [_1, _1.take] }.select(&:last)
      end
    end
  end
end
