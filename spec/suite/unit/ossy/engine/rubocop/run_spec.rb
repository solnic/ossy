# frozen_string_literal: true

require "ossy/engine/rubocop/run"

RSpec.describe Ossy::Engine::Rubocop::Run, "#call" do
  subject(:command) { Ossy::Engine::Rubocop::Run.new }

  it "returns succesful result" do
    result = command.(FIXTURES_ROOT.join("rubocop").join("good.rb"))

    expect(result).to be_success
    expect(result.summary.offense_count).to be(0)
  end

  it "returns failure result" do
    result = command.(FIXTURES_ROOT.join("rubocop").join("bad.rb"))

    expect(result).to be_failure
    expect(result.summary.offense_count).to be(1)
    expect(result.files.size).to be(1)

    file = result.files.first

    expect(file.offenses.size).to be(1)

    offense = file.offenses.first

    expect(offense.cop_name).to eql("Style/StringLiterals")
    expect(offense.location.line).to be(3)
  end
end
