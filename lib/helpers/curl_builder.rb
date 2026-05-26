##########################################################################
# Copyright 2022 Thoughtworks, Inc.
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
module CurlBuilder
  @generated_curls = ["#!/usr/bin/env bash"]

  def self.record_for_replay(method, url, headers, body)
    generated_curl = "curl #{basic_auth(headers)} --url #{url} -X #{method} #{to_curl_header(headers)} #{body_section(method, body)}"
    @generated_curls << generated_curl
    generated_curl
  end

  def self.all_urls
    @generated_curls
  end

  def self.clear_all_urls
    @generated_curls = ["#!/usr/bin/env bash"]
  end

  def self.body_section(method, body)
    return nil unless %w[PUT PATCH POST].include?(method)
    "-d '#{CGI.unescape(body.to_s)}'"
  end
  private_class_method :body_section

  def self.basic_auth(headers)
    return nil if headers.nil?
    authorization = headers['Authorization']
    return nil if authorization.nil?
    "-u #{Base64.decode64(authorization.sub('Basic ', ''))}"
  end
  private_class_method :basic_auth

  def self.to_curl_header(headers)
    return '' if headers.nil?
    headers.reject { |name, _| name.to_s.casecmp('authorization').zero? }
           .map { |name, value| "-H '#{name}: #{value}'" }
           .join(' ')
  end
  private_class_method :to_curl_header
end
