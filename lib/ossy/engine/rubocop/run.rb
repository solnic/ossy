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
      #
      # # json["files"] element
      # {"path"=>"spec/fixtures/rubocop/bad.rb",
      #  "offenses"=>
      #   [{"severity"=>"convention",
      #     "message"=> "blablabla",
      #     "cop_name"=>"Style/StringLiterals",
      #     "corrected"=>false,
      #     "correctable"=>true,
      #     "location"=>
      #      {"start_line"=>3,
      #       "start_column"=>1,
      #       "last_line"=>3,
      #       "last_column"=>30,
      #       "length"=>30,
      #       "line"=>3,
      #       "column"=>1}}]}
      class Result < Ossy::Struct
        attribute :summary do
          attribute :offense_count, Types::Integer
        end

        def self.build(json)
          klass =
            case json["summary"]["offense_count"]
            in 0 then Success
            in 1.. then Failure
            end
          klass.new(json)
        end

        def failure?
          !success?
        end
      end

      class Success < Result
        def success?
          true
        end
      end

      class Failure < Result
        attribute :files, Types::Array do
          attribute :path, Types::String
          attribute :offenses, Types::Array do
            attribute :severity, Types::String
            attribute :cop_name, Types::String
            attribute :location do
              attribute :start_line, Types::Integer
              attribute :start_column, Types::Integer
              attribute :last_line, Types::Integer
              attribute :last_column, Types::Integer
              attribute :line, Types::Integer
              attribute :column, Types::Integer
            end
          end
        end

        def success?
          false
        end
      end

      class Run < Ossy::CLI::Commands::Core
        option :path, desc: "Path to file(s)"
        option :format, desc: "Path to file(s)"

        def call(path:, format: "json", args: [])
          extra_opts = args.join(" ")
          result, output = exec("rubocop #{path} --format #{format} #{extra_opts}".strip)

          case format
          when "json" then Result.build(JSON.parse(output))
          else
            [result, output]
          end
        end

        def exec(cmd, opts = {})
          Open3.popen3(cmd, opts) do |_stdin, stdout, _stderr, wait_thr|
            [wait_thr.value, stdout.read]
          end
        end
      end
    end
  end
end
