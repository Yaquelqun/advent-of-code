# frozen_string_literal: true

require_relative '../helpers/input_parser'
require_relative '../models/bingo_card'

module AdventOfCode2021
  module Solvers
    # simulate bingo rounds
    class BingoCardChecker
      def initialize
        @data = Helpers::InputParser.new(endpoint: 'day4_input').parse_data
      end

      def solve
        puts "first card score: #{part1_solution}" # Solution: 21607
        puts "last card score: #{part2_solution}" # Solution: 
      end

      private

      attr_reader :data

      def part1_solution
        input_list, bingo_inputs = parse_input_data                                                     # correctly parse the input
        bingo_cards = bingo_inputs.map { Models::BingoCard.new(_1) }                                    # generate bingo card
        bingo_ractors = generate_ractors(bingo_cards)                                                   # put them in ractors
        input_list.each do |drawn_number|                                                               # for each number in the drawn list
          bingo_ractors.map { _1.send({ action: :mark_number, number: drawn_number }) }                 # send the number to each ractor
          winning_ractor = bingo_ractors.map { _1.send({ action: :check_winning }) }.map{ [_1, _1.take] }.detect(&:last) # if any of them is winning
          return winning_ractor.first.send({ action: :score }).take if winning_ractor
        end
      end

      def part2_solution
        input_list, bingo_inputs = parse_input_data                                                     # correctly parse the input
        score_list = []
        bingo_cards = bingo_inputs.map { Models::BingoCard.new(_1) }                                    # generate bingo card
        bingo_ractors = generate_ractors(bingo_cards)                                                   # put them in ractors
        input_list.each do |drawn_number|                                                               # for each number in the drawn list
          bingo_ractors.map { _1.send({ action: :mark_number, number: drawn_number }) }                 # send the number to each ractor
          winning_ractors = bingo_ractors.map { _1.send({ action: :check_winning }) }.map{ [_1, _1.take] }.select(&:last) # if any of them is winning
          winning_ractors.each do |winning_ractor, _|
            score_list << winning_ractor.send({ action: :score }).take 
            bingo_ractors -= [winning_ractor]
          end
        end
        return score_list.last
      end

      def parse_input_data
        input_list = data.first.split(',').map(&:to_i)
        bingo_inputs = [ ]
        current_bingo_input = [ ]
        data[2..].each do |input_line|
          if input_line == ''
            bingo_inputs << current_bingo_input
            current_bingo_input = [ ]
            next
          end

          current_bingo_input << input_line.split.map(&:to_i)
        end

        [input_list, bingo_inputs]
      end

      def generate_ractors(bingo_cards)
        bingo_cards.map do |bingo_card|
          Ractor.new(bingo_card) do |ractor_card|
            loop do
              msg = Ractor.receive
              case msg
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
    end
  end
end
