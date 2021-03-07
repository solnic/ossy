# frozen_string_literal: true

require "ossy/cli/github/workflow"

RSpec.describe Ossy::CLI::Github::Workflow, "#call" do
  subject(:command) do
    Ossy::CLI::Github::Workflow.new
  end

  let(:options) do
    { repo: "dry-rb/testing", name: "sync_configs" }
  end

  it "triggers a workflow", vcr: true, cassette: "gh-workflow-cli" do
    expect { command.(**options) }.to output(
      <<~STR
        Requesting: dry-rb/testing => sync_configs
        Success!
      STR
    ).to_stdout
  end
end
