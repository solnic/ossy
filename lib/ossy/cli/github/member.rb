# frozen_string_literal: true

require 'ossy/cli/commands/core'
require 'ossy/import'

module Ossy
  module CLI
    module Github
      class Member < Commands::Core
        include Import['github.client']

        desc 'Return org member identified by the full name'

        argument :name, required: true, desc: 'The member name'
        argument :org, required: true, desc: 'The org name'

        def call(name:, org:)
          result = client.member(name, org: org)

          if result
            puts result['login']
          end
        end
      end
    end
  end
end
