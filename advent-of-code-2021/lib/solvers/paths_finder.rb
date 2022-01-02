# frozen_string_literal: true

require_relative "../helpers/input_parser"
require_relative "../models/path"

module AdventOfCode2021
  module Solvers
    # Navigates cave map
    class PathsFinder
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day12_input").parse_data
      end

      def solve
        state = { incomplete_paths: [Models::Path.new(["start"], duplicate: true)], complete_paths_count: 0 }
        puts "paths amount: #{expand_paths(state)}" # Solution: 4754

        state = { incomplete_paths: [Models::Path.new(["start"], duplicate: false)], complete_paths_count: 0 }
        puts "path amount with one duplicate: #{expand_paths(state)}" # Solution: 143562
      end

      private

      attr_reader :data

      def expand_paths(state)
        until state[:incomplete_paths].empty?
          current_path = state[:incomplete_paths].shift
          possible_paths = find_possible_paths(current_path)
          possible_paths.each { _1.complete? ? state[:complete_paths_count] += 1 : state[:incomplete_paths] << _1 }
        end

        state[:complete_paths_count]
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
        return if new_neighbor == "start"

        node_list[current_node][:neighbors] << new_neighbor
        node_list[current_node][:type] ||= compute_type(current_node)
      end

      def compute_type(str)
        str.downcase == str ? "small" : "large"
      end

      def find_possible_paths(path)
        possible_paths = []
        nodes[path.current_cavern][:neighbors].each do |neighbor|
          possible_paths += path.new_path_to(neighbor, nodes)
        end
        possible_paths
      end
    end
  end
end
