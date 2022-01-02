# frozen_string_literal: true

# require each solver 1 by 1 as the days go by
require_relative "../solvers/sonar_sweep"
require_relative "../solvers/direction_interpreter"
require_relative "../solvers/diagnostic_reader"
require_relative "../solvers/bingo_card_checker"
require_relative "../solvers/vents_mapper"
require_relative "../solvers/lanternfish_watcher"
require_relative "../solvers/crab_aligner"
require_relative "../solvers/seven_segment_decoder"
require_relative "../solvers/height_parser"
require_relative "../solvers/syntax_checker"
require_relative "../solvers/octopus_watcher"
require_relative "../solvers/paths_finder"
require_relative "../solvers/page_folder"

module AdventOfCode2021
  # contains all solvers classes and define methods to access them
  class SolversDictionary
    SOLVER_CLASSES = {
      1 => AdventOfCode2021::Solvers::SonarSweep,
      2 => AdventOfCode2021::Solvers::DirectionInterpreter,
      3 => AdventOfCode2021::Solvers::DiagnosticReader,
      4 => AdventOfCode2021::Solvers::BingoCardChecker,
      5 => AdventOfCode2021::Solvers::VentsMapper,
      6 => AdventOfCode2021::Solvers::LanternFishWatcher,
      7 => AdventOfCode2021::Solvers::CrabAligner,
      8 => AdventOfCode2021::Solvers::SevenSegmentDecoder,
      9 => AdventOfCode2021::Solvers::HeightParser,
      10 => AdventOfCode2021::Solvers::SyntaxChecker,
      11 => AdventOfCode2021::Solvers::OctopusWatcher,
      12 => AdventOfCode2021::Solvers::PathsFinder,
      13 => AdventOfCode2021::Solvers::PageFolder
    }.freeze

    MAX_DAYS = SOLVER_CLASSES.count

    private_constant :SOLVER_CLASSES

    MAX_DAYS.times do |day|
      define_method("solve_day_#{day.next}") { SOLVER_CLASSES[day.next].new.solve }
    end

    def method_missing(*_)
      puts "Unsupported day"
    end

    def respond_to_missing?(method, *)
      method =~ /solve_day_(\d+)/ || super
    end
  end
end
