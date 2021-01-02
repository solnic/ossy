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

        option :identifiers, required: false, default: "",
          desc: "Key identifier that should be used for merging arrays of hashes"

        def call(source_path:, target_path:, output_path:, **opts)
          puts "Merging #{source_path} + #{target_path} into #{output_path}"

          identifiers = opts[:identifiers].split(",").map { |s| s.split(":") }.to_h

          source = YAML.load_file(source_path)
          target = YAML.load_file(target_path)

          output = deep_merge(source, target, identifiers)

          File.write(output_path, YAML.dump(output))
        end

        private

        def deep_merge(h1, h2, identifiers, &block)
          h1.merge(h2) do |key, val1, val2|
            if val1.is_a?(Hash) && val2.is_a?(Hash)
              deep_merge(val1, val2, identifiers, &block)
            elsif val1.is_a?(Array) && val2.is_a?(Array)
              if (id = identifiers[key])
                arr = (val1 + val2)
                  .group_by { |el| el.fetch(id) }
                  .values
                  .map { |arr| arr.size.equal?(2) ? deep_merge(*arr, identifiers) : arr }
                  .flatten(1)
                  .uniq

                arr
                  .map
                  .with_index { |el, idx|
                    (after = el.delete("_after")) ?
                      [el, arr.index(arr.detect { |a| a[id].eql?(after) }) + 1] :
                      [el, idx]
                  }.sort_by(&:last).map(&:first)
              else
                (val1 + val2).uniq
              end
            else
              val2
            end
          end
        end
      end
    end
  end
end
