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

    def solve_part1
      @path_checks = []
      number_of_paths_from('you', []) 
    end

    def solve_part2
      @path_checks = ['fft', 'dac']
      number_of_paths_from('svr', [])
    end

    private

    def number_of_paths_from(link_name, path)
      link = links.detect { |name, children| name == link_name }
      return 0 unless link

      if link.last.include? "out"
        puts "found one path: #{path}"
        return 1 if path & @path_checks == @path_checks
        return 0
      end
      link.last.map do 
        number_of_paths_from(_1, path + [link.first])
      end.sum
    end
  end
end
