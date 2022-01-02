# frozen_string_literal: true

module AdventOfCode2021
  module Models
    # Represents a path through the cavern system
    class Path
      attr_accessor :path, :duplicate

      def initialize(nodes, duplicate: false)
        @path = nodes
        @duplicate = duplicate
      end

      def current_cavern
        path.last
      end

      def new_path_to(neighbor, nodes)
        duplication = false
        case check_accessibility(neighbor, nodes)
        when false
          return []
        when "toggle_duplicate"
          duplication = true
        end

        [Path.new(path + [neighbor], duplicate: @duplicate || duplication)]
      end

      def complete?
        path.first == "start" && path.last == "end"
      end

      # rubocop:disable Metrics/CyclomaticComplexity
      def check_accessibility(neighbor, nodes)
        small_node = nodes[neighbor][:type] == small
        been_there = path.include?(neighbor)

        return false if neighbor == "start" || small_node && been_there && duplicate
        return "toggle_duplicate" if small_node && been_there && !duplicate
      end
      # rubocop:enable Metrics/CyclomaticComplexity
    end
  end
end
