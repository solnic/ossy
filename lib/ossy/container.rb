# frozen_string_literal: true

require 'dry/types'
require 'dry/system/container'
require 'dry/system/components'

module Ossy
  class Container < Dry::System::Container
    module Types
      include Dry.Types
    end

    use :logging
    use :env, inferrer: proc { ENV.fetch('OSSY_ENV') { 'development' }.to_sym }

    configure do |config|
      config.name = :ossy
      config.default_namespace = 'ossy'
    end

    load_paths! 'lib'

    boot(:settings, from: :system) do
      settings do
        key :github_login, Types::String.constrained(filled: true)
        key :github_token, Types::String.constrained(filled: true)
      end
    end
  end
end
