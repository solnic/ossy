# frozen_string_literal: true

require 'hanami/cli/registry'

module Ossy
  module CLI
    module Commands
      extend Hanami::CLI::Registry

      require 'ossy/cli/github/workflow'

      register 'github', aliases: %w[gh] do |github|
        github.register 'workflow', Github::Workflow, aliases: %w[w]
      end
    end
  end
end
