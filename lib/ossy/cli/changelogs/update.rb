# frozen_string_literal: true

require "ossy/cli/commands/core"
require "ossy/import"
require "ossy/release"

require "yaml"

module Ossy
  module CLI
    module Changelogs
      class Update < Commands::Core
        desc "Adds a new entry to a changelog config"

        argument :config_path, required: true, desc: "The path to the changelog config"
        argument :message, required: true, desc: "Message text including the entry"

        KEYS = %w[version summary date fixed added changed].freeze

        def call(config_path:, message:)
          attrs = YAML.safe_load(message)
          target = YAML.load_file(config_path)

          version = attrs["version"] || target[0]["version"]
          entry = target.detect { |e| e["version"].eql?(version) } || {}

          release = Release.new(attrs.merge(version: version))

          release.each do |type, logs|
            (entry[type.to_s] ||= []).concat(logs).uniq!
          end

          entry.update(release.meta)

          entry = KEYS.map { |key| [key, entry[key]] }.to_h

          unless target.include?(entry)
            target.unshift(entry.merge(release.meta))
          end

          File.write(config_path, YAML.dump(target))
        end
      end
    end
  end
end
