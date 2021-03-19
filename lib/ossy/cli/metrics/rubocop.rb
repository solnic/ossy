# frozen_string_literal: true

require "ossy/cli/commands/core"
require "ossy/cli/import"
require "ossy/release"

require "yaml"
require "tilt"
require "ostruct"

module Ossy
  module CLI
    module Metrics
      class Rubocop < Commands::Core
        include CLI::Import[run_rubocop: "engine.rubocop.run"]

        desc "Runs rubocop"

        argument :path, required: true, desc: "The path to file(s)"
        option :format, required: true, desc: "Output format"
        option :do_exit, required: false,
                         desc: "Whether the command should exit with the same status as rubocop"
        option :silence, required: false,
                         desc: "Whether the rubocop output should be displayed"

        def call(path:, silence: "false", do_exit: "true", args: [], **opts)
          result, output = run_rubocop.(path: path, args: args, **opts)

          warn output if silence.eql?("false") && !result.success?

          exit(result.exitstatus) if do_exit.eql?("true")

          [result, output]
        end
      end
    end
  end
end
