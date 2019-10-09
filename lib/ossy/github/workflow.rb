# frozen_string_literal: true

require 'ossy/import'

require 'http'

module Ossy
  module Github
    class Workflow
      include Import[:settings]

      BASE_URL = 'https://api.github.com'

      def call(repo, name)
        post("repos/#{repo}/dispatches", event_type: name)
      end

      def request(meth, path, opts = {})
        http.public_send(meth, url(path), opts)
      end

      def post(path, input)
        request(:post, path, json: input)
      end

      def url(path)
        "#{BASE_URL}/#{path}"
      end

      def http
        HTTP
          .headers('Accept': 'application/vnd.github.everest-preview+json')
          .basic_auth(user: settings.github_login, pass: settings.github_token)
      end
    end
  end
end
