# frozen_string_literal: true

require "ossy/github/workflow"

RSpec.describe Ossy::Github::Workflow, "#call" do
  subject(:workflow) do
    Ossy::Github::Workflow.new
  end

  it "triggers a workflow in the provided repo", vcr: true, cassette: "gh-workflow" do
    result = workflow.("dry-rb/dry-rb.org", "ci")

    expect(result.status).to be(204)
  end

  it "triggers a workflow in the provided repo", vcr: true, cassette: "gh-workflow-payload" do
    result = workflow.("dry-rb/testing", "release", tag: "v1.2.3")

    expect(result.status).to be(204)
  end
end
