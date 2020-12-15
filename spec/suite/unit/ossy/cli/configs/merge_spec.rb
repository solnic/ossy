# frozen_string_literal: true

require "ossy/cli/configs/merge"

RSpec.describe Ossy::CLI::Configs::Merge, "#call" do
  subject(:command) do
    Ossy::CLI::Configs::Merge.new
  end

  let(:options) do
    { source_path: config_path("1"), target_path: config_path("2"), output_path: output_path }
  end

  def config_path(num)
    SPEC_ROOT.join("fixtures/config_#{num}.yml")
  end

  def output_path
    SPEC_ROOT.join("../tmp/config_output.yml")
  end

  after do
    FileUtils.rm(output_path)
  end

  it "merges two yaml configs into a new one" do
    command.(options)

    output = YAML.load_file(output_path)

    expect(output).to eql(
      "test" => {
        "text" => "Hello Universe",
        "nums" => [1, 2, 3, 4],
        "data" => { "foo" => "bar", "bar" => "baz" }
      }
    )
  end
end
