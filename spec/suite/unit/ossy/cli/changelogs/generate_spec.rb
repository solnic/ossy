# frozen_string_literal: true

require 'ossy/cli/changelogs/generate'

RSpec.describe Ossy::CLI::Changelogs::Generate, '#call' do
  subject(:command) do
    Ossy::CLI::Changelogs::Generate.new(command_name: 'generate')
  end

  def config_path
    SPEC_ROOT.join("fixtures/changelog.yml")
  end

  def data_path
    SPEC_ROOT.join("fixtures/project.yml")
  end
  def template_path
    SPEC_ROOT.join("fixtures/changelog.erb")
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

  context "without additional data" do
    let(:options) do
      { config_path: config_path,
        output_path: output_path,
        template_path: template_path }
    end

    it 'generates CHANGELOG.md from the config yaml' do
      command.(options)

      expected = File.read(expected_output_path)
      output = File.read(output_path)

      expect(output).to eql(expected)
    end
  end

  context "without additional data" do
    let(:options) do
      { config_path: config_path,
        output_path: output_path,
        template_path: template_path,
        data_path: data_path }
    end

    it 'generates CHANGELOG.md from the config yaml with additional data' do
      command.(options)

      expected = File.read(expected_output_path)
      output = File.read(output_path)

      expect(output).to include('test-project')
      expect(output).to include('this is a test project')
    end
  end
end
