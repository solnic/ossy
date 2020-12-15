# frozen_string_literal: true

require "ossy/engine/rubocop/run"

RSpec.describe Ossy::Engine::Rubocop::Run, "#call" do
  subject(:command) { Ossy::Engine::Rubocop::Run.new }

  it "returns succesful result" do
    result = command.(SPEC_ROOT.join("spec_helper.rb"))

    expect(result.summary.offense_count).to be(0)
  end
end
