# frozen_string_literal: true

require 'ossy/import'

require 'net/http'

module Ossy
  module Github
    class Workflow
      include Import[:settings]

      BASE_URL = 'https://api.github.com'

      METHODS = {
        get: Net::HTTP::Get,
        post: Net::HTTP::Post,
        put: Net::HTTP::Put,
        patch: Net::HTTP::Patch,
        delete: Net::HTTP::Delete
      }

      def call(repo, name)
        post("repos/#{repo}/dispatches", event_type: name)
      end

      def request(meth, path, opts = {})
        request = METHODS.fetch(meth).new(uri(path))

        request['Accept'] = 'application/vnd.github.everest-preview+json'
        request.basic_auth(settings.github_login, settings.github_token)
        request.set_form_data(opts) unless opts.empty?

        http.request(request)
      end

      def uri(path)
        URI("#{BASE_URL}/#{path}")
      end

      def post(path, input)
        request(:post, path, json: input)
      end

      def http
        Net::HTTP.new(BASE_URL)
      end
    end
  end
end
