# frozen_string_literal: true

require 'ossy/github/client'

RSpec.describe Ossy::Github::Client do
  subject(:client) do
    Ossy::Github::Client.new
  end

  describe '#membership?' do
    it 'returns true if a given user has active membership', vcr: true, cassette: 'gh-membership-no' do
      result = client.membership?('dry-bot', org: 'dry-rb', team: 'core')

      expect(result).to be(true)
    end

    it 'returns false if a given user is not found', vcr: true, cassette: 'gh-membership-yes' do
      result = client.membership?('nothere', org: 'dry-rb', team: 'core')

      expect(result).to be(false)
    end
  end

  describe '#tagger' do
    it 'returns tagger and verification status set to true', vcr: true, cassette: 'gh-tag-signed' do
      result = client.tagger(repo: 'dry-rb/dry-validation', tag: 'v1.2.0')

      expect(result[:tagger]).to_not be_empty
      expect(result[:verified]).to be(true)
    end

    it 'returns tagger and verification status set to false', vcr: true, cassette: 'gh-tag-not-signed' do
      result = client.tagger( repo: 'dry-rb/dry-validation', tag: 'v1.0.0')

      expect(result[:tagger]).to_not be_empty
      expect(result[:verified]).to be(false)
    end
  end
end
