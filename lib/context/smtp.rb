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

require 'midi-smtp-server'
require 'mail'

module Context
  class CapturingSmtpd < MidiSmtpServer::Smtpd
    attr_reader :messages

    def initialize(*args, **kwargs)
      super
      @messages = []
      @mutex = Mutex.new
    end

    def on_message_data_event(ctx)
      parsed = Mail.read_from_string(ctx[:message][:data])
      @mutex.synchronize { @messages << parsed }
    end

    def on_auth_event(_ctx, _authorization_id, _authentication_id, _authentication_secret)
      # Accept any credentials so tests can exercise AUTH without configuring a real user store.
    end

    def clear
      @mutex.synchronize { @messages.clear }
    end
  end

  class SmtpServer
    include Singleton

    DEFAULT_PORT = 10025
    DEFAULT_HOST = '127.0.0.1'.freeze

    def start(port: DEFAULT_PORT, host: DEFAULT_HOST)
      return @server if @server
      @server = CapturingSmtpd.new(
        ports: port,
        hosts: host,
        max_processings: 4,
        auth_mode: :AUTH_OPTIONAL,
        logger_severity: Logger::WARN
      )
      @server.start
      @server
    end

    def stop
      return unless @server
      @server.stop
      @server = nil
    end

    def messages
      @server ? @server.messages.dup : []
    end

    def clear
      @server&.clear
    end

    def wait_for_message(timeout: 10)
      deadline = Time.now + timeout
      until Time.now >= deadline
        return messages.last unless messages.empty?
        sleep 0.2
      end
      nil
    end
  end
end
