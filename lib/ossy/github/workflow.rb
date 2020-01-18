# frozen_string_literal: true

require 'ossy/github/client'

module Ossy
  module Github
    class Workflow < Client
      def call(repo, name, payload = {})
        post("repos/#{repo}/dispatches", event_type: name, client_payload: payload)
      end
    end
  end
end
