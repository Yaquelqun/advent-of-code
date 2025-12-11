# frozen_string_literal: true

module Solvers
  # Problem:
  class ServerDetangler
    attr_reader :links

    def initialize(input: "day11")
      # get each line and split them into single chars
      @links = Helpers::InputParser.new(input: input)
                                         .parse_data
                                         .map { _1.split(':') }
                                         .map { [_1, _2.split]}
                                        #  .map { ::Helpers::Server.new(*_1)}
    end

    def solve
      puts "parts1: #{solve_part1}" # is correct
      puts "parts2: #{solve_part2}" # is correct
    end

    def solve_part1(result = 0)
      # @paths_state = {}
      number_of_paths_from('you') 
    end

    def solve_part2(result = 0); end

    private

    def number_of_paths_from(link_name)
      link = links.detect { |name, children| name == link_name }
      return 1 if link.last.include? "out"
      link.last.map { number_of_paths_from(_1) }.sum
    end
  end
end
