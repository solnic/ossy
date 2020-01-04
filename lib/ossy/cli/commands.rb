# frozen_string_literal: true

require 'dry/cli/registry'

module Ossy
  module CLI
    module Commands
      extend Dry::CLI::Registry

      require 'ossy/cli/github/workflow'
      require 'ossy/cli/github/update_file'

      require 'ossy/cli/templates/compile'

      register 'github', aliases: %w[gh] do |github|
        github.register 'workflow', Github::Workflow, aliases: %w[w]
        github.register 'update_file', Github::UpdateFile, aliases: %w[uf]
      end

      register 'templates', aliases: %w[t] do |github|
        github.register 'compile', Templates::Compile, aliases: %w[c]
      end
    end
  end
end
