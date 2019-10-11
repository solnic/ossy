# frozen_string_literal: true

require 'hanami/cli/registry'

module Ossy
  module CLI
    module Commands
      extend Hanami::CLI::Registry

      require 'ossy/cli/github/workflow'
      require 'ossy/cli/github/update_file'

      register 'github', aliases: %w[gh] do |github|
        github.register 'workflow', Github::Workflow, aliases: %w[w]
        github.register 'update_file', Github::UpdateFile, aliases: %w[uf]
      end
    end
  end
end
