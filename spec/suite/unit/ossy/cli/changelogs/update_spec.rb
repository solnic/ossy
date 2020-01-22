# frozen_string_literal: true

require 'ossy/cli/changelogs/update'

RSpec.describe Ossy::CLI::Changelogs::Update, '#call' do
  subject(:command) do
    Ossy::CLI::Changelogs::Update.new(command_name: 'update')
  end

  let(:options) do
    { config_path: config_path, message: message }
  end

  def config_path
    SPEC_ROOT.join("../tmp/changelog.yml")
  end

  before do
    FileUtils.cp(SPEC_ROOT.join("fixtures/changelog.yml"), config_path)
  end

  after do
    FileUtils.rm(config_path)
  end

  context 'with a single entry' do
    let(:message) do
      <<~YML
        fixed: "This is a fix"
        added: "This is an addition"
        changed: "This is a change"
      YML
    end

    it 'adds new entries' do
      command.(options)

      output = YAML.load_file(config_path)

      expect(output[0]['fixed'].last).to eql('This is a fix')
      expect(output[0]['added'].last).to eql('This is an addition')
      expect(output[0]['changed'].last).to eql('This is a change')
    end
  end

  context 'with multiple entries' do
    let(:message) do
      <<~YML
        fixed:
        - "This is a fix"
        added:
        - "This is an addition"
        changed:
        - "This is a change"
      YML
    end

    it 'adds new entries' do
      command.(options)

      output = YAML.load_file(config_path)

      expect(output[0]['fixed'].last).to eql('This is a fix')
      expect(output[0]['added'].last).to eql('This is an addition')
      expect(output[0]['changed'].last).to eql('This is a change')
    end
  end

  context 'when existing version is included' do
    let(:message) do
      <<~YML
        version: 0.1.0
        fixed: "This is a fix"
        added: "This is an addition"
        changed: "This is a change"
      YML
    end

    it 'adds new entries' do
      command.(options)

      output = YAML.load_file(config_path)

      expect(output[1]['version']).to eql('0.1.0')
      expect(output[1]['fixed'].last).to eql('This is a fix')
      expect(output[1]['added'].last).to eql('This is an addition')
      expect(output[1]['changed'].last).to eql('This is a change')
    end
  end

  context 'when a new version is included' do
    let(:message) do
      <<~YML
        version: 1.0.0
        fixed: "This is the final fix"
        added: "This is the final addition"
        changed: "This is the final change"
      YML
    end

    it 'adds new entries' do
      command.(options)

      output = YAML.load_file(config_path)

      expect(output[0]['version']).to eql('1.0.0')
      expect(output[0]['fixed'].last).to eql('This is the final fix')
      expect(output[0]['added'].last).to eql('This is the final addition')
      expect(output[0]['changed'].last).to eql('This is the final change')
    end
  end
end
