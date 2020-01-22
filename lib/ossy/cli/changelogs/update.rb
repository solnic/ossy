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
          transform_keys(&:to_sym)

          transform_types do |type|
            if type.default?
              type.constructor do |value|
                value.nil? ? Dry::Types::Undefined : value
              end
            else
              type
            end
          end

          ChangeList = Types::Coercible::Array
            .of(Types::String.constrained(filled: true))
            .default { [] }

          attribute? :version, Types::Version
          attribute? :fixed, ChangeList
          attribute? :added, ChangeList
          attribute? :changed, ChangeList

          def each(&block)
            %i[fixed added changed].each do |type|
              yield(type, self[type]) unless self[type].empty?
            end
          end
        end

        def call(config_path:, message:)
          entry = Entry.new(YAML.load(message))
          target = YAML.load_file(config_path)

          release =
            if entry.version
              target.detect { |r| r['version'].eql?(entry.version) } || {}
            else
              target.first
            end

          entry.each do |type, logs|
            (release[type.to_s] ||= []).concat(logs)
          end

          unless release['version']
            release['version'] = entry.version
            target.unshift(release)
          end

          File.write(config_path, YAML.dump(target))
        end
      end
    end
  end
end
