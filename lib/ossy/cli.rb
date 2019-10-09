# frozen_string_literal: true

require 'hanami/cli'
require 'ossy/cli/commands'

module Ossy
  module CLI
    class Application < Hanami::CLI
      def self.start
        new.()
      end

      def self.new(commands = CLI::Commands)
        super
      end
    end
  end
end
