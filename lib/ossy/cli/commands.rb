# frozen_string_literal: true

require "dry/cli/registry"

module Ossy
  module CLI
    module Commands
      extend Dry::CLI::Registry

      require "ossy/cli/github/workflow"
      require "ossy/cli/github/membership"
      require "ossy/cli/github/tagger"
      require "ossy/cli/github/member"
      require "ossy/cli/github/update_file"

      require "ossy/cli/changelogs/generate"
      require "ossy/cli/changelogs/update"

      require "ossy/cli/releases/generate"

      require "ossy/cli/configs/merge"

      require "ossy/cli/templates/compile"

      require "ossy/cli/metrics/rubocop"

      register "github", aliases: %w[gh] do |github|
        github.register "workflow", Github::Workflow, aliases: %w[w]
        github.register "membership", Github::Membership, aliases: %w[m]
        github.register "tagger", Github::Tagger, aliases: %w[t]
        github.register "member", Github::Member, aliases: %w[om]
        github.register "update_file", Github::UpdateFile, aliases: %w[uf]
      end

      register "templates", aliases: %w[t] do |templates|
        templates.register "compile", Templates::Compile, aliases: %w[c]
      end

      register "changelogs", aliases: %w[ch] do |changelogs|
        changelogs.register "generate", Changelogs::Generate, aliases: %w[g]
        changelogs.register "update", Changelogs::Update, aliases: %w[u]
      end

      register "releases", aliases: %w[r] do |releases|
        releases.register "generate", Releases::Generate, aliases: %w[g]
      end

      register "configs", aliases: %w[c] do |configs|
        configs.register "merge", Configs::Merge, aliases: %w[m]
      end

      register "metrics", aliases: %w[m] do |configs|
        configs.register "rubocop", Metrics::Rubocop, aliases: %w[rc]
      end
    end
  end
end
