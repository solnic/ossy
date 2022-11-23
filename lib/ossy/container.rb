# frozen_string_literal: true

require "dry/system"
require "dry/system/container"
require "dry/system/provider_sources"

require "ossy/types"

module Ossy
  class Container < Dry::System::Container
    use :env, inferrer: proc { ENV.fetch("OSSY_ENV", "development").to_sym }

    configure do |config|
      config.root = Pathname(__dir__).join("../../")
      config.name = :ossy

      config.component_dirs.add "lib" do |dir|
        dir.namespaces.add "ossy", key: nil
      end
    end

    add_to_load_path! "lib"

    register_provider(:settings, from: :dry_system) do
      settings do
        setting :github_login, constructor: Types::String.constrained(filled: true)
        setting :github_token, constructor: Types::String.constrained(filled: true)
      end
    end
  end
end
