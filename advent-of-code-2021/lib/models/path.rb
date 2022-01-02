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
        when 'toggle_duplicate'
          duplication = true
        end

        [Path.new(path + [neighbor], duplicate: @duplicate || duplication)]
      end

      def complete?
        path.first == 'start' && path.last == 'end'
      end

      def check_accessibility(neighbor, nodes)
        return false if neighbor == 'start'
        return false if nodes[neighbor][:type] == 'small' && path.include?(neighbor) && duplicate
        return 'toggle_duplicate' if nodes[neighbor][:type] == 'small' && path.include?(neighbor) && !duplicate
      end
    end
  end
end
