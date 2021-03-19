# frozen_string_literal: true

require "ossy/cli/commands/core"
require "ossy/cli/import"
require "ossy/release"

require "yaml"
require "tilt"
require "ostruct"

module Ossy
  module CLI
    module Changelogs
      class Generate < Commands::Core
        class Context < OpenStruct
          def self.new(data)
            super(releases: data.map(&Release))
          end

          def update(hash)
            hash.each { |k, v| self[k.to_sym] = v }
            self
          end
        end

        desc "Generates a changelog markdown file from a yaml config"

        argument :config_path, required: true, desc: "The path to the changelog config"
        argument :output_path, required: true, desc: "The path to the output md file"
        argument :template_path, required: true, desc: "The path to the changelog ERB template"

        option :data_path, required: false, desc: "Optional path to additional data yaml file"

        def call(config_path:, output_path:, template_path:, data_path: nil)
          puts "Generating #{output_path} from #{config_path} using #{template_path}"

          ctx_data = YAML.load_file(config_path)
          template = Tilt.new(template_path)

          context = Context.new(ctx_data)

          if data_path
            key = File.basename(data_path).gsub(".yml", "")
            data = YAML.load_file(data_path)

            context.update(key => OpenStruct.new(data))
          end

          output = template.render(context)

          File.write(output_path, "#{output.strip}\n")
        end
      end
    end
  end
end
