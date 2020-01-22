# frozen_string_literal: true

require 'ossy/cli/commands/core'
require 'ossy/import'
require 'ossy/types'

require 'yaml'

module Ossy
  module CLI
    module Changelogs
      class Update < Commands::Core
        desc 'Adds a new entry to a changelog config'

        argument :config_path, required: true, desc: 'The path to the changelog config'
        argument :message, required: true, desc: 'Message text including the entry'

        class Entry < Dry.Struct
          attribute :type, Types::String.enum('fixed', 'added', 'changed')
          attribute :logs, Types::Coercible::Array.of(Types::String.constrained(filled: true))
        end

        def call(config_path:, message:)
          entries = YAML.load(message).map { |k, v| Entry.new(type: k, logs: v) }
          target = YAML.load_file(config_path)

          release = target.first

          entries.each do |entry|
            (release[entry.type] ||= []).concat(entry.logs)
          end

          File.write(config_path, YAML.dump(target))
        end
      end
    end
  end
end
