# frozen_string_literal: true

require "ossy/cli/configs/merge"

RSpec.describe Ossy::CLI::Configs::Merge, "#call" do
  subject(:command) do
    Ossy::CLI::Configs::Merge.new
  end

  let(:options) do
    { source_path: config_path("1"),
      target_path: config_path("2"),
      output_path: output_path,
      identifiers: "steps:name" }
  end

  def config_path(num)
    SPEC_ROOT.join("fixtures/config_#{num}.yml")
  end

  def output_path
    SPEC_ROOT.join("../tmp/config_output.yml")
  end

  after do
    FileUtils.rm(output_path) if output_path.exist?
  end

  it "merges two yaml configs into a new one" do
    command.(**options)

    output = YAML.load_file(output_path, permitted_classes: [Date])

    expect(output).to eql(
      "test" => {
        "text" => "Hello Universe",
        "nums" => [1, 2, 3, 4],
        "data" => {
          "foo" => "bar",
          "bar" => "baz",
          "steps" => [
            { "name" => "first", "tag" => "customized" },
            { "name" => "second" },
            { "name" => "third", "tag" => "customized" }
          ]
        }
      }
    )
  end
end
