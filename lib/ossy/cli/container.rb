# frozen_string_literal: true

require "dry/system/container"
require "dry/system/components"

require "ossy/cli/types"

module Ossy
  module CLI
    class Container < Dry::System::Container
      use :env, inferrer: proc { ENV.fetch("OSSY_ENV", "development").to_sym }

      configure do |config|
        config.root = Pathname(__dir__).join("../../..")
        config.name = :ossy
        config.default_namespace = "ossy"
      end

      load_paths! "lib"

      boot(:settings, from: :system) do
        settings do
          key :github_login, CLI::Types::String.constrained(filled: true)
          key :github_token, CLI::Types::String.constrained(filled: true)
        end
      end
    end
  end
end
