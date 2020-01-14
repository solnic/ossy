# frozen_string_literal: true

require 'ossy/cli/changelogs/generate'

RSpec.describe Ossy::CLI::Changelogs::Generate, '#call' do
  subject(:command) do
    Ossy::CLI::Changelogs::Generate.new(command_name: 'generate')
  end

  let(:options) do
    { config_path: config_path, output_path: output_path }
  end

  def config_path
    SPEC_ROOT.join("fixtures/changelog.yml")
  end

  def expected_output_path
    SPEC_ROOT.join("fixtures/CHANGELOG.md")
  end

  def output_path
    SPEC_ROOT.join("../tmp/CHANGELOG.md")
  end

  after do
    FileUtils.rm(output_path)
  end

  it 'generates CHANGELOG.md from the config yaml' do
    command.(options)

    expected = File.read(expected_output_path)
    output = File.read(output_path)

    expect(output).to eql(expected)
  end
end
