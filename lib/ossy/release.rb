# frozen_string_literal: true

require "ossy/cli/types"
require "ossy/struct"

module Ossy
  class Release < Ossy::Struct
    attribute :version, CLI::Types::Version
    attribute? :date, CLI::Types::ReleaseDate
    attribute? :summary, CLI::Types::Summary
    attribute? :fixed, CLI::Types::ChangeList
    attribute? :added, CLI::Types::ChangeList
    attribute? :changed, CLI::Types::ChangeList

    def each
      %i[fixed added changed].each do |type|
        yield(type, self[type]) unless self[type].empty?
      end
    end

    def meta
      %i[version date summary]
        .map { |key| [key.to_s, self[key]] if attributes.key?(key) }
        .compact
        .to_h
    end

    def fixed?
      !fixed.empty?
    end

    def added?
      !added.empty?
    end

    def changed?
      !changed.empty?
    end
  end
end
