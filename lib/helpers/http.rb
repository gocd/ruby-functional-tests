##########################################################################
# Copyright 2026 Thoughtworks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################################################################

require 'faraday'

module Helpers
  module HTTP
    class RecordCalls < Faraday::Middleware
      def call(env)
        APIBuilder.record_tested(env.method.to_s.upcase, env.url.to_s) if defined?(APIBuilder)
        CurlBuilder.record_for_replay(env.method.to_s.upcase, env.url.to_s, env.request_headers, env.body) if defined?(CurlBuilder)
        @app.call env
      end
    end

    # Subclass of Faraday's built-in :raise_error middleware. The parent's
    # default exposes err.response as a Hash, which is asymmetric with the
    # success path where the response is a Faraday::Response. This subclass
    # lets the parent decide which specific Faraday::Error subclass to raise
    # (Faraday::ResourceNotFound, Faraday::UnauthorizedError, etc.), then
    # swaps the Hash for a real Faraday::Response object before propagating.
    class RaiseErrorWithResponse < Faraday::Response::RaiseError
      def on_complete(env)
        super
      rescue Faraday::Error => err
        err.instance_variable_set(:@response, Faraday::Response.new(env)) if err.response.is_a?(Hash)
        raise
      end
    end

    # Shared Faraday connection. Use directly as Helpers::HTTP.conn.get(...) etc.
    # Configured to:
    #   - URL-form-encode Hash payloads (Rack-style)
    #   - Raise Faraday::ClientError / Faraday::ServerError on 4xx/5xx, with a
    #     Faraday::Response on err.response (symmetric with the success path)
    #   - Trigger the APIBuilder + CurlBuilder hooks via InterceptMiddleware
    def self.conn
      @conn ||= Faraday.new do |conn|
        conn.request :url_encoded
        conn.use RecordCalls
        conn.use RaiseErrorWithResponse
        conn.adapter Faraday.default_adapter
      end
    end

    # Connection that does NOT raise on 4xx/5xx — for the small set of call
    # sites that explicitly assert on non-2xx status codes (auth failures,
    # 404 lookups, etc.) and need the response object regardless of status.
    def self.raw_conn
      @raw_conn ||= Faraday.new do |conn|
        conn.request :url_encoded
        conn.use RecordCalls
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
