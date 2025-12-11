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
      puts "parts1: #{solve_part1}" # 534 is correct
      puts "parts2: #{solve_part2}" # is correct
    end

    def solve_part1
      number_of_paths('you', 'out') 
    end

    # svr => fft => dac => out
    def solve_part2
      puts "since fft comes before dac"
      puts "the final sum is"
      svr_fft = number_of_paths('svr', 'dac')
      puts "#{svr_fft} paths from svr to fft * "
      fft_dac = number_of_paths('dac', 'fft')
      puts "#{fft_dac} paths from svr to fft * "
      dac_out = number_of_paths('fft', 'out') 
      puts "#{dac_out} paths from svr to fft  = "
      svr_fft * fft_dac * dac_out
    end
 
    private

    def number_of_paths(link_name, exit_name)
      link = links.detect { |name, _| name == link_name }
      return 0 unless link

      if link.last.include? exit_name
        return 1
      end
      link.last.reduce(0) do |acc, child_name| 
        acc + number_of_paths(child_name, exit_name)
      end
    end

    def find_all_parents(link_name)
      more_parents = links.select { _2.include? link_name }
      # byebug
      parents = more_parents
      loop do
        puts "looking at #{more_parents.count} links"
        return parents.uniq.compact if more_parents.size == 0
        current_parents = more_parents
        more_parents = []
        current_parents.each do |link_name, children_name|
          new_parents = links.select { _2.include? link_name}
          more_parents += new_parents
        end
        parents += more_parents
      end
      
    end
  end
end
