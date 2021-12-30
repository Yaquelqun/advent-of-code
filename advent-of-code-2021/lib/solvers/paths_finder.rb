# frozen_string_literal: true

require_relative "../helpers/input_parser"

module AdventOfCode2021
  module Solvers
    # Navigates cave map
    class PathsFinder
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day12_input").parse_data
      end

      def solve
        puts "paths amount: #{part1_solution}" # Solution: 
        puts ": #{part2_solution}" # Solution:
      end

      private

      attr_reader :data

      def part1_solution
        state = { incomplete_paths: [['start']], complete_paths: [] }
        until incomplete_paths.empty?
          # get the first path
          # generate all possible paths from there
          # next if no other path
          # add complete paths to the complete paths and incomplete paths to the incomplete paths
        end
      end

      def part2_solution
      end

      def parsed_input
        @parsed_input ||= data.map { _1.split("-") }
      end

      def nodes
        @nodes ||= begin
          nodes = Hash.new { |hash, key| hash[key] = { type: nil, neighbors: [] } }
          parsed_input.each do |start, finish|
            modify_node(nodes, start, finish)
            modify_node(nodes, finish, start)
          end
          nodes
        end
      end

      def modify_node(node_list, current_node, new_neighbor)
        node_list[current_node][:neighbors] << new_neighbor
        node_list[current_node][:type] ||= compute_type(current_node)
      end

      def compute_type(str)
        str.downcase == str ? 'small' : 'big'
      end
    end
  end
end
