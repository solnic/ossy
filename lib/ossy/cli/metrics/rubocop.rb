# frozen_string_literal: true

require "ossy/cli/commands/core"
require "ossy/import"
require "ossy/release"

require "yaml"
require "tilt"
require "ostruct"

module Ossy
  module CLI
    module Metrics
      class Rubocop < Commands::Core
        include Import[run_rubocop: "engine.rubocop.run"]

        desc "Runs rubocop"

        argument :path, required: true, desc: "The path to file(s)"
        option :format, required: true, desc: "Output format"
        option :do_exit, required: false, desc: "Whether the command should exit with the same status as rubocop"

        def call(path:, do_exit: "true", args: [], **opts)
          result, output = run_rubocop.(path: path, args: args, **opts)

          $stderr.puts output unless result.success?

          exit(result.exitstatus) if do_exit.eql?("true")

          [result, output]
        end
      end
    end
  end
end
