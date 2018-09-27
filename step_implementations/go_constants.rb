##########################################################################
# Copyright 2018 ThoughtWorks, Inc.
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

require 'socket'

class GoConstants
  HOSTNAME = Socket.gethostname
  GO_VERSION = ENV['GO_VERSION'] || '16.11.0'
  SERVER_PORT = ENV['GO_SERVER_PORT'] || '8253'
  SERVER_SSL_PORT = ENV['GO_SERVER_SSL_PORT'] || '8254'
  SERVER_DIR = Dir["target/go-server-#{GO_VERSION}"].find {|f| File.directory?(f)}
  AGENT_DIR = Dir["target/go-agent-#{GO_VERSION}"].find {|f| File.directory?(f)}
  SERVER_MEM = ENV['GAUGE_GO_SERVER_MEM'] || '512m'
  SERVER_MAX_MEM = ENV['GAUGE_GO_SERVER_MAX_MEM'] || '1024m'
  LDAP_SERVER_IP = 'localhost:10389'
  ANALYTICS_LICENCE_KEY = ENV['ANALYTICS_LICENSE_KEY'] || 'eyJleHBpcnkiOiAiMjA5My0wNS0xMCIsICJvcmciOiAiVGhvdWdodFdvcmtzIEluYyIsICJzaWduYXR1cmUiOiAiSGdhb3NNcmQxNEJjbmdtU2QxSDAyQ2dVd3NsY2xvZWRBd0xoQjRXUThUbTRyWXJtdkg0Q251SDJTUE5tVkJPaFdCODYrM091UTR2b3prekZpNFowR2c9PSJ9Cg=='

  TEMP_DIR = '/tmp/materials'.freeze
  GAUGE_AGENT_DIR = 'target/gauge_agents'.freeze
  CONFIG_PATH = 'resources/config'.freeze
  FILE_BASED_PLUGIN_ID = 'cd.go.authentication.passwordfile'.freeze
  AGENTS_API_VERSION = 'application/vnd.go.cd.v4+json'.freeze

  OWASP_ZAP_PATH = '/opt/homebrew-cask/Caskroom/owasp-zap/2.5.0/OWASP-ZAP.app/Contents/MacOS/OWASP-ZAP.sh'.freeze

  GO_SERVER_BASE_URL = "http://#{HOSTNAME}:#{SERVER_PORT}/go".freeze
  GO_SERVER_BASE_SSL_URL = "https://#{HOSTNAME}:#{SERVER_SSL_PORT}/go".freeze
  GO_CONFIG_SCHEMA_VERSION = '84'.freeze
  GO_AGENT_SYSTEM_PROPERTIES = " -Dagent.get.work.delay=500 \
                                -Dagent.get.work.interval=500 \
                                -Dagent.ping.delay=500 \
                                -Dagent.ping.interval=500 \
                                -Dgo.gauge.agent=true".freeze

  GO_SERVER_SYSTEM_PROPERTIES = "-Dalways.reload.config.file=true \
                          -Dcruise.buildCause.producer.interval=1000 \
                          -Dcruise.material.update.interval=3000 \
                          -Dcruise.material.update.delay=1000 \
                          -Dcruise.produce.build.cause.interval=1000 \
                          -Dcruise.produce.build.cause.delay=1000 \
                          -Dmaterial.update.idle.interval=1000 \
                          -Dcruise.xmpp.port=61221 \
                          -Dcruise.agent.service.refresh.interval=5000 \
                          -Dcruise.shine.sparql.url=http://localhost:8253/go/shine/sparql.xml \
                          -Dcruise.shine.stage.feed=http://localhost:8253/go/api/feeds/stages.xml \
                          -Dagent.connection.timeout=50 \
                          -Dcruise.unresponsive.job.warning=1 \
                          -Dcruise.pipelineStatus.cache.interval=800 \
                          -Dcommand.repo.warning.timeout=30000 \
                          -Dnew.plugins.framework.enabled=Y \
                          -Dgo.gauge.server=true \
                          -DDB_DEBUG_MODE=true \
  #{ENV['ADDITIONAL_SERVER_SYSTEM_PROPERITES']}".freeze
end
