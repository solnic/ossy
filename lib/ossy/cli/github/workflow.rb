# frozen_string_literal: true

require 'json'

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

        option :payload, required: false, desc: 'Optional client payload'

        def call(repo:, name:, payload: "{}")
          puts "Requesting: #{repo} => #{name}"

          result = workflow.(repo, name, JSON.load(payload))

          if result.status.eql?(204)
            puts 'Success!'
          else
            puts "Failure! #{result.inspect}"
          end
        end
      end
    end
  end
end
