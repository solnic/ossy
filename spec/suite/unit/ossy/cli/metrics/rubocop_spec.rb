# frozen_string_literal: true

require "ossy/cli/metrics/rubocop"

RSpec.describe Ossy::CLI::Metrics::Rubocop, "#call" do
  subject(:command) do
    Ossy::CLI::Metrics::Rubocop.new
  end

  let(:path) { FIXTURES_ROOT.join("rubocop").join("bad.rb") }

  let(:opts) do
    { path: path, format: "github" }
  end

  context "running against a single file" do
    it "outputs result using provided format" do
      result, output = command.(**opts)

      expect(result).to_not be_success

      expect(output).to include("bad.rb")
      expect(output).to include("Prefer double-quoted strings")
    end
  end
end
