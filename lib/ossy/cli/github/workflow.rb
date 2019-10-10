# frozen_string_literal: true

require 'ossy/cli/commands/core'
require 'ossy/import'

module Ossy
  module CLI
    module Github
      class Workflow < Commands::Core
        include Import['github.workflow']

        desc 'Start a GitHub workflow'

        argument :repo, required: true, desc: 'The name of the repository on GitHub'
        argument :name, required: true, desc: 'The name of the workflow'

        def call(repo:, name:)
          puts "Requesting: #{repo} => #{name}"
          result = workflow.(repo, name)

          if result.code.eql?(204)
            puts 'Success!'
          else
            puts "Failure! #{result.inspect}"
          end
        end
      end
    end
  end
end
