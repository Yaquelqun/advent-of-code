# frozen_string_literal: true

# require each solver 1 by 1 as the days go by
require_relative "../solvers/calories_counter"
require_relative "../solvers/rock_paper_scissors_player"
require_relative "../solvers/rucksack_parser"
require_relative "../solvers/section_cleaner"
require_relative "../solvers/cargo_crate_planner"
require_relative "../solvers/communication_packet_parser"

module AdventOfCode2022
  # contains all solvers classes and define methods to access them
  class SolversDictionary
    SOLVER_CLASSES = {
      1 => AdventOfCode2022::Solvers::CaloriesCounter,
      2 => AdventOfCode2022::Solvers::RockPaperScissorsSolver,
      3 => AdventOfCode2022::Solvers::RucksackParser,
      4 => AdventOfCode2022::Solvers::SectionCleaner,
      5 => AdventOfCode2022::Solvers::CargoCratePlanner,
      6 => AdventOfCode2022::Solvers::CommunicationPacketParser,
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
