# frozen_string_literal: true

require 'ossy/import'

require 'http'
require 'json'

module Ossy
  module Github
    class Client
      include Import[:settings]

      BASE_URL = 'https://api.github.com'

      def membership?(username, org:, team:)
        path = "orgs/#{org}/teams/#{team}/memberships/#{username}"
        resp = get(path)

        return false unless resp.code.equal?(200)

        json = JSON.parse(resp.body)

        json['state'].eql?('active')
      end

      def tagger(repo:, tag:)
        path = "repos/#{repo}/git/ref/tags/#{tag}"
        resp = get(path)

        return false unless resp.code.equal?(200)

        sha = JSON.parse(resp.body)['object']['sha']

        path = "repos/#{repo}/git/tags/#{sha}"
        resp = get(path)

        return false unless resp.code.equal?(200)

        json = JSON.parse(resp.body)

        { tagger: json['tagger'], verified: json['verification']['verified'] }
      end

      def member(name, org:)
        path = "orgs/#{org}/members"
        resp = get(path)

        return nil unless resp.code.equal?(200)

        user = JSON.parse(resp.body)
          .map { |member| user(member['login']) }
          .detect { |user| user['name'].eql?(name) }

        user
      end

      def user(login)
        path = "users/#{login}"
        resp = get(path)

        return nil unless resp.code.equal?(200)

        JSON.parse(resp.body)
      end

      def request(meth, path, opts = {})
        http.public_send(meth, url(path), opts)
      end

      def get(path, opts = {})
        request(:get, path, params: opts)
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
