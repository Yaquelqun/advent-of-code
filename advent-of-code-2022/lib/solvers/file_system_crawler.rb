# frozen_string_literal: true

require_relative "../helpers/input_parser"
require_relative "../models/folder"

module AdventOfCode2022
  module Solvers
    class FileSystemCrawler
      def initialize
        @data = Helpers::InputParser.new(endpoint: "day7_input").parse_data
        @home_directory = Folder.new(name: "/", parent_folder: nil)
        generate_file_structure
      end

      def solve
        puts "total size of <= 100_000: #{solve_part1}" # Solution: 1182909
        puts "smallest possible directory to delete: #{solve_part2}" # Solution: 
      end

      private

      attr_reader :data, :home_directory
      attr_accessor :current_folder


      def solve_part1
        folders_to_parse = [@home_directory]
        result = 0
        until folders_to_parse.empty?
          folder = folders_to_parse.shift
          folders_to_parse |= folder.contained_folders
          result += folder.size if folder.size <= 100_000
        end
        result
      end

      def solve_part2
        folders_to_parse = [@home_directory]
        smallest_size = @home_directory.size
        until folders_to_parse.empty?
          folder = folders_to_parse.shift
          folders_to_parse |= folder.contained_folders
          smallest_size = folder.size if folder.size >= needed_space && folder.size < smallest_size
        end

        smallest_size
      end

      def generate_file_structure
        @current_folder = @home_directory
        data.map { parse_line(_1) }
            .map { send(_1[:action], **_1[:args])}
      end

      # rubocop:disable Metrics/MethodLength
      def parse_line(data_line)
        case data_line
        when /^\$ ls/
          { action: "list", args: {} }
        when %r{^\$ cd /}
          { action: "go_home", args: {} }
        when /^\$ cd \.\./
          { action: "go_to_parent", args: {} }
        when /^\$ cd (.*)/
          { action: "move_to", args: { folder_name: data_line.match(/^\$ cd (.*)/)[1] } }
        when /^dir (.*)/
          { action: "generate_folder", args: { folder_name: data_line.match(/^dir (.*)/)[1] } }
        when /^(\d*) (.*)/
          match = data_line.match(/^(\d*) (.*)/)
          { action: "generate_file", args: { size: match[1].to_i, file_name: match[2] } }
        else
          { action: "fail!", args: { data_line: data_line } }
        end
      end
      # rubocop:enable Metrics/MethodLength

      def list; end

      def go_home
        @current_folder = @home_directory
      end

      def go_to_parent
        @current_folder = @current_folder.parent_folder || @home_directory
      end

      def move_to(folder_name:)
        target_folder = @current_folder.find_folder(folder_name)
        @current_folder = target_folder
      end

      def generate_folder(folder_name:)
        @current_folder.find_or_generate_folder(folder_name: folder_name)
      end

      def generate_file(file_name:, size:)
        @current_folder.find_or_generate_file(file_name: file_name, size: size)
      end

      def needed_space
        @needed_space ||= 30_000_000 - (70_000_000 - @home_directory.size)
      end
    end
  end
end
