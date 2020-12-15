# frozen_string_literal: true

require "ossy/cli/commands/core"
require "ossy/import"

module Ossy
  module CLI
    module Github
      class Tagger < Commands::Core
        include Import["github.client"]

        desc "Return tagger email for a verified tag"

        argument :repo, required: true, desc: "The repo"
        argument :tag, required: true, desc: "The tag name"

        def call(repo:, tag:)
          result = client.tagger(repo: repo, tag: tag)

          if result && result[:verified].equal?(true)
            puts result[:tagger]["name"]
          end
        end
      end
    end
  end
end
