# frozen_string_literal: true

require "dry/types"

module Ossy
  module CLI
    module Types
      include Dry.Types()

      Version = CLI::Types::String.constrained(eql: "unreleased") |
                CLI::Types::String.constrained(format: /\d+\.\d+\.\d+/)

      Summary = CLI::Types::String.constrained(filled: true).optional

      ReleaseDate = CLI::Types::Nil | CLI::Types::String | CLI::Types::Params::Date

      ChangeList = CLI::Types::Coercible::Array
        .of(CLI::Types::String.constrained(filled: true))
        .default { [] }
    end
  end
end
