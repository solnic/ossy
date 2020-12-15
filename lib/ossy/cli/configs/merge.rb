# frozen_string_literal: true

require "ossy/cli/commands/core"
require "ossy/import"

require "yaml"

module Ossy
  module CLI
    module Configs
      class Merge < Commands::Core
        desc "Merge two yaml config files into a new one"

        argument :source_path, required: true, desc: "The path to the source file"
        argument :target_path, required: true, desc: "The path to the target file"
        argument :output_path, required: true, desc: "The path to the output file"

        def call(source_path:, target_path:, output_path:)
          puts "Merging #{source_path} + #{target_path} into #{output_path}"

          source = YAML.load_file(source_path)
          target = YAML.load_file(target_path)

          output = deep_merge(source, target)

          File.write(output_path, YAML.dump(output))
        end

        private

        def deep_merge(h1, h2, &block)
          h1.merge(h2) do |_key, val1, val2|
            if val1.is_a?(Hash) && val2.is_a?(Hash)
              deep_merge(val1, val2, &block)
            elsif val1.is_a?(Array) && val2.is_a?(Array)
              (val1 + val2).uniq
            else
              val2
            end
          end
        end
      end
    end
  end
end
