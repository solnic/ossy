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

        def call(path:, **opts)
          puts run_rubocop.(path: path, **opts)
        end
      end
    end
  end
end
