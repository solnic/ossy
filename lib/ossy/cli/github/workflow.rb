# frozen_string_literal: true

require 'ossy/cli/commands/core'

module Ossy
  module CLI
    module Github
      class Workflow < Commands::Core
        desc 'Start a GitHub workflow'

        argument :repo, required: true, desc: 'The name of the repository on GitHub'
        argument :name, required: true, desc: 'The name of the workflow'

        def call(repo:, name:)
          puts "Workflow: #{repo} => #{name}"
        end
      end
    end
  end
end
