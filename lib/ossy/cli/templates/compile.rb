# frozen_string_literal: true

require "dry/inflector"
require "ossy/cli/commands/core"
require "ossy/cli/import"

require "tilt"
require "erb"
require "yaml"
require "ostruct"

module Ossy
  module CLI
    module Templates
      class Compile < Commands::Core
        class Context < OpenStruct
          Inflector = Dry::Inflector.new do |i|
            i.acronym "CLI"
          end

          def inflector
            Inflector
          end
        end

        include CLI::Import["github.workflow"]

        desc "Compile an erb template"

        argument :source_path, required: true, desc: "The path to the template file"
        argument :target_path, required: true, desc: "The path to the output file"
        argument :data_file, required: true, desc: "The path to yaml data file"

        def call(source_path:, target_path:, data_file:)
          puts "Compiling #{source_path} => #{target_path}"

          data = YAML.load_file(data_file)
          template = Tilt.new(source_path)
          output = template.render(Context.new(data))

          File.write(target_path, output)
        end
      end
    end
  end
end
