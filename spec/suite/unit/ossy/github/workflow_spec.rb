# frozen_string_literal: true

require 'ossy/github/workflow'

RSpec.describe Ossy::Github::Workflow, '#call' do
  subject(:workflow) do
    Ossy::Github::Workflow.new
  end

  it 'triggers a workflow in the provided repo', vcr: true, cassette: 'gh-workflow' do
    result = workflow.('dry-rb/dry-rb.org', 'ci')

    expect(result.code).to be(204)
  end
end
