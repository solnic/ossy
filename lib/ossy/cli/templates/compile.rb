# frozen_string_literal: true

require 'ossy/cli/commands/core'
require 'ossy/import'
require 'tilt'
require 'erb'

module Ossy
  module CLI
    module Templates
      class Compile < Commands::Core
        include Import['github.workflow']

        desc 'Compile an erb template'

        argument :source_path, required: true, desc: 'The path to the template file'
        argument :target_path, required: true, desc: 'The path to the output file'

        def call(source_path:, target_path:)
          puts "Compiling #{source_path} => #{target_path}"

          template = Tilt.new(source_path)
          output = template.render

          File.write(target_path, output)
        end
      end
    end
  end
end
