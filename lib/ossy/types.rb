# frozen_string_literal: true

require 'dry/types'

module Ossy
  module Types
    include Dry.Types()

    Version = Types::String.constrained(eql: 'unreleased') |
              Types::String.constrained(format: %r[\d+\.\d+\.\d+])

    Summary = Types::String.constrained(filled: true).optional

    ReleaseDate = Types::Nil | Types::String | Types::Params::Date

    ChangeList = Types::Coercible::Array
      .of(Types::String.constrained(filled: true))
      .default { [] }
  end
end
