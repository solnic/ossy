# frozen_string_literal: true

require "ossy/cli/commands/core"
require "open-uri"

module Ossy
  module CLI
    module Github
      class UpdateFile < Commands::Core
        desc "Update provided file using a canonical source in another repository"

        argument(:repo, required: true, desc: "Source repository")
        argument(:file, required: true, desc: "File path ie owner/repo:path/to/file")
        option(:branch, required: false, desc: "Branch name", default: "master")

        def call(repo:, file:, branch:)
          url = "https://raw.githubusercontent.com/#{repo}/#{branch}/shared/#{file}"

          content = open(url).read

          puts "Writing to #{file}"

          File.write("./#{file}", content)

          system "git commit #{file} -m 'Update #{file}'"
        end
      end
    end
  end
end
