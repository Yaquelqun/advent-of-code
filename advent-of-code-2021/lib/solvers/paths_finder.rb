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
        until state[:incomplete_paths].empty?
          current_path = state[:incomplete_paths].shift # get the first path
          possible_paths = find_possible_paths(current_path) # generate all possible paths from there
          next if possible_paths.empty? # next if no other path

          # add complete paths to the complete paths and incomplete paths to the incomplete paths
          possible_paths.each { check_path_completion?(_1) ? state[:complete_paths] << _1 : state[:incomplete_paths] << _1 }
        end

        state[:complete_paths].count
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
        str.downcase == str ? 'small' : 'large'
      end

      def find_possible_paths(path)
        possible_paths = []
        nodes[path.last][:neighbors].each do |neighbor|
          possible_paths << (path + [neighbor]) if nodes[neighbor][:type] == 'large'
          possible_paths << (path + [neighbor]) if nodes[neighbor][:type] == 'small' && !path.include?(neighbor)
        end
        possible_paths
      end

      def check_path_completion?(path)
        path.first == 'start' && path.last == 'end'
      end
    end
  end
end
