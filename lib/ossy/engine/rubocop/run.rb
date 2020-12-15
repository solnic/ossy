# frozen_string_literal: true

require "open3"

require "ossy/cli/commands/core"
require "ossy/struct"

module Ossy
  module Engine
    module Rubocop
      # {
      #    "metadata" : {
      #       "ruby_platform" : "x86_64-darwin20",
      #       "ruby_version" : "2.7.2",
      #       "ruby_engine" : "ruby",
      #       "ruby_patchlevel" : "137",
      #       "rubocop_version" : "1.6.1"
      #    },
      #    "files" : [
      #       {
      #          "offenses" : [],
      #          "path" : "spec/spec_helper.rb"
      #       }
      #    ],
      #    "summary" : {
      #       "target_file_count" : 1,
      #       "inspected_file_count" : 1,
      #       "offense_count" : 0
      #    }
      # }
      class Result < Ossy::Struct
        attribute :summary do
          attribute :offense_count, Types::Integer
        end
      end

      class Run < Ossy::CLI::Commands::Core
        argument :path, desc: "Path to file(s)"

        def call(path)
          json = JSON.parse(exec("rubocop #{path} --format json"))
          Result.new(json)
        end

        def exec(cmd, opts = {})
          Open3.popen3(cmd, opts) do |_stdin, stdout, stderr, wait_thr|
            stdout.read
          end
        end
      end
    end
  end
end
