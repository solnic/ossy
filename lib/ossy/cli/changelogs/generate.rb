# frozen_string_literal: true

require 'ossy/cli/commands/core'
require 'ossy/import'
require 'ossy/types'

require 'yaml'
require 'tilt'
require 'dry/struct'

module Ossy
  module CLI
    module Changelogs
      class Generate < Commands::Core
        class Context < OpenStruct
          def self.new(data)
            super(releases: data.map(&Release))
          end
        end

        class Release < Dry::Struct
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

          ChangeList = Types::Array.of(Types::String).default(EMPTY_ARRAY)

          attribute :version, Types::Version
          attribute :date, Types::Date
          attribute? :summary, Types::String.optional
          attribute? :fixed, ChangeList
          attribute? :added, ChangeList
          attribute? :changed, ChangeList

          def fixed?
            !fixed.empty?
          end

          def added?
            !added.empty?
          end

          def changed?
            !changed.empty?
          end
        end

        desc 'Generates a changelog markdown file from a yaml config'

        argument :config_path, required: true, desc: 'The path to the changelog config'
        argument :output_path, required: true, desc: 'The path to the output md file'

        def call(config_path:, output_path:)
          puts "Generating #{output_path} from #{config_path}"

          data = YAML.load_file(config_path)
          template = Tilt.new(template_path)

          output = template.render(Context.new(data))

          File.write(output_path, "#{output.strip}\n")
        end

        private

        def template_path
          Pathname(__FILE__).dirname.join('template.erb')
        end
      end
    end
  end
end
