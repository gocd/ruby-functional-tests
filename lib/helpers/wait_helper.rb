##########################################################################
# Copyright 2022 ThoughtWorks, Inc.
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

require 'timeout'

module Helpers
  module Wait
    def retry_until_true(options={}, &block)
      if block_given?
        max_tries = options[:max_tries] || 2
        period = options[:delay] || 3
        tries = 0
        begin
          raise "retry" unless block.call
        rescue
          if tries < max_tries
            tries += 1
            sleep period
            retry
          end
        end
      end
    end

    def wait_till_event_occurs_or_bomb(wait_time, message)
      Timeout.timeout(wait_time) do
        loop do
          yield if block_given?
          sleep 1
        end
      end
    rescue Timeout::Error
      raise "The event did not occur - #{message}. Wait timed out"
    end

    def wait_for_event(wait_time, message)
      Timeout.timeout(wait_time) do
        loop do
          yield if block_given?
          sleep 1
        end
      end
    rescue Timeout::Error
      p "The event did not occur - #{message}. Wait timed out"
    end

  end
end
