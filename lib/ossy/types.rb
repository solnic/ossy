require 'dry/types'

module Ossy
  module Types
    include Dry.Types()

    Version = Types::String.constrained(format: %r[\d+\.\d+\.\d+])
  end
end
