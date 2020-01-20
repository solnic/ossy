# frozen_string_literal: true

require 'ossy/cli/commands/core'
require 'ossy/import'

module Ossy
  module CLI
    module Github
      class Tagger < Commands::Core
        include Import['github.client']

        desc 'Return tagger email for a verified tag'

        argument :repo, required: true, desc: 'The repo'
        argument :tag_sha, required: true, desc: 'The tag sha'

        def call(repo:, tag_sha:)
          result = client.tagger(repo: repo, tag_sha: tag_sha)

          if result && result[:verified].equal?(true)
            puts result[:tagger]['email']
          end
        end
      end
    end
  end
end
