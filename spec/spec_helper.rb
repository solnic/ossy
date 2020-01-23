# frozen_string_literal: true

require 'bundler/setup'
require 'byebug'

require 'ossy/container'

# Ossy::Container.finalize!(freeze: false)

SPEC_ROOT = Pathname(__FILE__).dirname

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = SPEC_ROOT.join('fixtures/vcr_cassettes')

  config.hook_into :webmock

  settings = Ossy::Container[:settings]

  config.filter_sensitive_data('github-login') do
    settings.github_login
  end

  config.filter_sensitive_data('github-token') do
    settings.github_token
  end

  config.before_record do |i|
    i.response.headers.delete('Set-Cookie')
    i.request.headers.delete('Authorization')

    uri = URI.parse(i.request.uri)
    i.request.uri.sub!(/:\/\/.*#{Regexp.escape(uri.host)}/, "://#{uri.host}" )
  end

  config.register_request_matcher :anonymized_uri do |request_1, request_2|
    (URI(request_1.uri).port == URI(request_2.uri).port) &&
      URI(request_1.uri).path == URI(request_2.uri).path
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.around(vcr: true) do |example|
    VCR.use_cassette(example.metadata[:cassette]) do
      example.run
    end
  end
end
