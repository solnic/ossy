# frozen_string_literal: true

require 'ossy/cli/commands/core'
require 'ossy/import'

module Ossy
  module CLI
    module Github
      class Membership < Commands::Core
        include Import['github.client']

        desc 'Check if a given user has an active membership in a team'

        argument :username, required: true, desc: 'The username'
        argument :org, required: true, desc: 'The name of the org'
        argument :team, required: true, desc: 'The name of the team'

        option :verify, required: false

        def call(username:, org:, team:, verify: 'false')
          result = client.membership?(username, org: org, team: team)

          if verify.eql?('true')
            exit(1) unless result
          else
            puts "#{username} has active membership in #{org}/@#{team}"
          end
        end
      end
    end
  end
end
