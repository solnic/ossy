# frozen_string_literal: true

require "ossy/cli/releases/generate"

RSpec.describe Ossy::CLI::Releases::Generate, "#call" do
  subject(:command) do
    Ossy::CLI::Releases::Generate.new
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
    SPEC_ROOT.join("fixtures/RELEASE-v0.1.1.md")
  end

  def output_path
    SPEC_ROOT.join("../tmp/RELEASE-v0.1.1.md")
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

    it "generates RELEASE-v0.1.1.md from the config yaml" do
      command.(**options)

      expected = File.read(expected_output_path)
      output = File.read(output_path)

      expect(output).to eql(expected)
    end
  end
end
