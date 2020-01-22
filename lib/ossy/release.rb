# frozen_string_literal: true

require 'ossy/types'
require 'ossy/struct'

module Ossy
  class Release < Ossy::Struct
    attribute :version, Types::Version
    attribute? :date, Types::ReleaseDate
    attribute? :summary, Types::Summary
    attribute? :fixed, Types::ChangeList
    attribute? :added, Types::ChangeList
    attribute? :changed, Types::ChangeList

    def each(&block)
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
