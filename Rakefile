# #########################GO-LICENSE-START################################
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
# #########################GO-LICENSE-END##################################

require 'bundler/setup'
require 'childprocess'
require 'fileutils'
require 'sys-proctable'
require 'os'
require 'json'
require 'open-uri'
include Sys

GO_TRUNK_DIRNAME   = ENV['GO_TRUNK_DIR'] || 'gocd'
GO_PLUGINS_DIRNAME = ENV['GO_PLUGINS_DIR'] || 'go-plugins'
GO_JOB_RUN_COUNT   = ENV['GO_JOB_RUN_COUNT']
GO_JOB_RUN_INDEX   = ENV['GO_JOB_RUN_INDEX']
VERSION_NUMBER     = ENV['GO_VERSION'] || (raise 'Environment variable GO_VERSION not set, exiting......')
GITHUB_TOKEN       = ENV['GITHUB_TOKEN'] || (raise 'Environment variable GITHUB_TOKEN not set - needed to pull plugin releases without being rate-limited...')

GAUGE_TAGS       = ENV['GAUGE_TAGS'] || 'smoke'
LOAD_BALANCED    = GO_JOB_RUN_COUNT && GO_JOB_RUN_INDEX
DEVELOPMENT_MODE = !ENV['GO_PIPELINE_NAME']
GO_PIPELINE_COUNTER = ENV['GO_PIPELINE_COUNTER'] || 0

DOCKER_EA_PLUGIN_RELEASE_URL                = ENV['DOCKER_EA_PLUGIN_RELEASE_URL'] || 'https://api.github.com/repos/gocd-contrib/docker-elastic-agents/releases/latest'
K8S_EA_PLUGIN_RELEASE_URL                   = ENV['K8S_EA_PLUGIN_RELEASE_URL'] || 'https://api.github.com/repos/gocd/kubernetes-elastic-agents/releases/latest'
YUM_REPO_POLLER_PLUGIN_RELEASE_URL          = ENV['YUM_REPO_POLLER_PLUGIN_RELEASE_URL'] || 'https://api.github.com/repos/gocd/gocd-yum-repository-poller-plugin/releases/latest'
ELASTICAGENTS_PLUGIN_RELEASE_URL            = ENV['ELASTICAGENTS_PLUGIN_RELEASE_URL'] || 'https://api.github.com/repos/gocd-contrib/elastic-agent-skeleton-plugin/releases/latest'
DOCKER_REGISTRY_ARTIFACT_PLUGIN_RELEASE_URL = ENV['DOCKER_REGISTRY_ARTIFACT_PLUGIN_RELEASE_URL'] || 'https://api.github.com/repos/gocd/docker-registry-artifact-plugin/releases/latest'
ANALYTICS_PLUGIN_DOWNLOAD_URL               = ENV['ANALYTICS_PLUGIN_DOWNLOAD_URL'] || 'https://api.github.com/repos/gocd/gocd-analytics-plugin/releases/latest'
LDAP_AUTHORIZATION_PLUGIN_DOWNLOAD_URL      = ENV['LDAP_AUTHORIZATION_PLUGIN_DOWNLOAD_URL'] || 'https://api.github.com/repos/gocd/gocd-ldap-authorization-plugin/releases/latest'
MAVEN_REPO_POLLER_PLUGIN_RELEASE_URL        = ENV['MAVEN_REPO_POLLER_PLUGIN_RELEASE_URL'] || 'https://api.github.com/repos/1and1/go-maven-poller/releases/24528030'

desc 'cleans all directories'
task :clean_all do
  rm_rf 'target'
  rm_rf 'reports'
  mkdir_p 'target'
  rm_rf 'godata' if Dir.exist? 'godata' # this folder is needed for only when running on docker
  mkdir_p 'godata'
  if DEVELOPMENT_MODE
    cd "../#{GO_TRUNK_DIRNAME}" do
      sh './gradlew -q clean'
    end
    cd "../#{GO_PLUGINS_DIRNAME}" do
      sh './gradlew -q clean'
    end
  end
end

desc 'cleans only test directories'
task :clean_test do
  rm_rf 'target'
  rm_rf 'reports'
  mkdir_p 'target'
end

zips = %w[server agent].each_with_object({}) do |package, accumulator|
  accumulator[package] = if DEVELOPMENT_MODE
                           Dir[File.join('..', GO_TRUNK_DIRNAME, 'installers', 'target', 'distributions', 'zip', "go-#{package}*.zip")].first
                         else
                           Dir[File.join('target', 'zip', "go-#{package}*.zip")].first
                         end

  accumulator
end

identifiers = {server: '-Dgo.gauge.server=true', agent: '-Dgo.gauge.agent=true', gauge: 'go_gauge'}

identifiers.each do |package, process_argument|
  namespace package do
    desc "Kill the #{package} identified using #{process_argument}"
    task :kill do
      if process = ProcTable.ps.find {|each_process| each_process.environ[process_argument]}
        $stderr.puts "Found PID(#{process.pid}) matching #{process_argument}"
        if OS.windows?
          sh("TASKKILL /PID #{process.pid}")
        else
          sh("kill -2 #{process.pid}")
        end

        sleep 2
        $stderr.puts "PID(#{process.pid}) exists after 2 seconds, force killing"
        if ProcTable.ps.find {|each_process| each_process.pid == process.pid}
          if OS.windows?
            sh("TASKKILL /PID /F #{process.pid}")
          else
            sh("kill -9 #{process.pid}")
          end
        end
      end
    end
  end

  desc 'Kills all running processes spun by the tests'
  task kill: "#{package}:kill"
end

zips.each do |package, file|
  namespace package do
    desc "extract out #{package}"
    task :prepare do
      sh("unzip -q -o #{file} -d target")
      if package == 'server'
        mkdir_p "target/go-server-#{VERSION_NUMBER}/config"
        cp "config-files/server-logback-include.xml", "target/go-server-#{VERSION_NUMBER}/config/logback-include.xml"
      end
    end

    desc "Build go #{package}"
    task :build do
      Bundler.with_original_env do
        cd "../#{GO_TRUNK_DIRNAME}" do
          sh "./gradlew -q #{package}GenericZip"
        end
      end
    end
  end
  task prepare: "#{package}:prepare"
end

namespace :plugins do

  def download_url_from_latest_release(releases_url)
    JSON.parse(URI.open(releases_url, "Authorization" => "token #{GITHUB_TOKEN}").read)['assets'][0]['browser_download_url']
  end

  desc 'copy the plugins in the go server'
  task :prepare do
    mkdir_p "target/go-server-#{VERSION_NUMBER}/plugins/external"
    if DEVELOPMENT_MODE
      cp_r "../#{GO_PLUGINS_DIRNAME}/target/go-plugins-dist/.", "target/go-server-#{VERSION_NUMBER}/plugins/external"
    else
      cp_r 'target/go-plugins-dist/.', "target/go-server-#{VERSION_NUMBER}/plugins/external"
    end

    sh "curl -sL --compressed -H \"Authorization: token #{GITHUB_TOKEN}\" --output target/go-server-#{VERSION_NUMBER}/plugins/external/elastic-agent-skeleton-plugin.jar #{download_url_from_latest_release(ELASTICAGENTS_PLUGIN_RELEASE_URL)}"
    sh "curl -sL --compressed -H \"Authorization: token #{GITHUB_TOKEN}\" --output target/go-server-#{VERSION_NUMBER}/plugins/external/docker-registry-artifact-plugin.jar #{download_url_from_latest_release(DOCKER_REGISTRY_ARTIFACT_PLUGIN_RELEASE_URL)}"
    sh "curl -sL --compressed -H \"Authorization: token #{GITHUB_TOKEN}\" --output target/go-server-#{VERSION_NUMBER}/plugins/external/docker-elastic-agents-plugin.jar #{download_url_from_latest_release(DOCKER_EA_PLUGIN_RELEASE_URL)}"
    sh "curl -sL --compressed -H \"Authorization: token #{GITHUB_TOKEN}\" --output target/go-server-#{VERSION_NUMBER}/plugins/external/k8s-elastic-agents.jar #{download_url_from_latest_release(K8S_EA_PLUGIN_RELEASE_URL)}"
    sh "curl -sL --compressed -H \"Authorization: token #{GITHUB_TOKEN}\" --output target/go-server-#{VERSION_NUMBER}/plugins/external/ldap_authorization_plugin.jar #{download_url_from_latest_release(LDAP_AUTHORIZATION_PLUGIN_DOWNLOAD_URL)}"
    sh "curl -sL --compressed -H \"Authorization: token #{GITHUB_TOKEN}\" --output target/go-server-#{VERSION_NUMBER}/plugins/external/maven_repo_poller_plugin.jar #{download_url_from_latest_release(MAVEN_REPO_POLLER_PLUGIN_RELEASE_URL)}"
    sh "curl -sL --compressed -H \"Authorization: token #{GITHUB_TOKEN}\" --output target/go-server-#{VERSION_NUMBER}/plugins/external/yum_repo_poller_plugin.jar #{download_url_from_latest_release(YUM_REPO_POLLER_PLUGIN_RELEASE_URL)}"
  end

  desc 'task for preparing analytics plugin'
  task :prepare_analytics do
    sh "curl -sL --compressed -H \"Authorization: token #{GITHUB_TOKEN}\" --output target/go-server-#{VERSION_NUMBER}/plugins/external/analytics-plugin.jar #{download_url_from_latest_release(ANALYTICS_PLUGIN_DOWNLOAD_URL)}"

    # preparing the database - drop and recreate analytics database
    ENV['ANALYTICS_DB_NAME_TO_USE'] = "#{ENV['ANALYTICS_DB_NAME'] || "analytics"}"
    ENV['POSTGRES_DB_HOST_TO_USE']  = "#{ENV['DB_HOST'] || "localhost"}"

    puts "Using DB: #{ENV['ANALYTICS_DB_NAME_TO_USE']} on host: #{ENV['POSTGRES_DB_HOST_TO_USE']}"

    db_user = ENV['DB_USER'] || 'postgres'

    drop_db_command   = "java -jar tools/run_with_postgres.jar #{ENV['POSTGRES_DB_HOST_TO_USE']} 5432 postgres #{db_user} '' 'DROP DATABASE IF EXISTS #{ENV['ANALYTICS_DB_NAME_TO_USE']}'"
    create_db_command = "java -jar tools/run_with_postgres.jar #{ENV['POSTGRES_DB_HOST_TO_USE']} 5432 postgres #{db_user} '' 'CREATE DATABASE #{ENV['ANALYTICS_DB_NAME_TO_USE']}'"
    system("#{drop_db_command} && #{create_db_command}") || (puts "Failed to drop and recreate DB. Tried running: #{drop_db_command} && #{create_db_command}"; exit 1)

    puts "Recreated analytics DB: #{ENV['ANALYTICS_DB_NAME_TO_USE']}"
  end

  desc 'gradle build go plugins'
  task build: %i[version api] do
    cd "../#{GO_PLUGINS_DIRNAME}" do
      go_full_version = JSON.parse(File.read("../#{GO_TRUNK_DIRNAME}/installers/target/distributions/meta/version.json"))['go_full_version']
      sh "./gradlew -q jar -PgoVersion=#{go_full_version} -DskipTests"
    end
  end

  task :version do
    cd "../#{GO_TRUNK_DIRNAME}" do
      sh './gradlew -q installers:versionFile'
    end
  end

  task :api do
    cd "../#{GO_TRUNK_DIRNAME}" do
      sh './gradlew -q plugin-infra:go-plugin-api:install plugin-infra:go-plugin-api-internal:install'
    end
  end
end

desc 'Builds server, agent, plugins if running in development mode'
task :build_all do
  if DEVELOPMENT_MODE
    ['server:build', 'agent:build', 'plugins:build'].each do |t|
      Rake::Task[t].invoke
    end
  end
end

desc 'Bump up schemaVersion'
task 'bump-schema' do
  version = ENV['VERSION'].to_s

  raise 'Please provide VERSION' if version.empty?
  Dir['./resources/config/*.xml'].each do |path|
    content = File.read(path)
    next unless content =~ /xsi:noNamespaceSchemaLocation="cruise-config.xsd"/
    puts "Replacing content in #{path}"
    content = content.gsub(/schemaVersion="\d+"/, %(schemaVersion="#{version}"))
    File.open(path, 'w') {|f| f.write(content)}
  end
end

desc 'initializes the filesystem to run tests'
task prepare: %w[plugins:prepare db:prepare]

task :test do
  if LOAD_BALANCED
    if ENV['DEBUG_GAUGE']
      sh "bundle exec gauge  -l debug --tags '#{GAUGE_TAGS}' -n #{GO_JOB_RUN_COUNT} -g #{GO_JOB_RUN_INDEX} --max-retries-count=3 --retry-only=retry-flaky run specs"
    else
      sh "bundle exec gauge --tags '#{GAUGE_TAGS}' -n #{GO_JOB_RUN_COUNT} -g #{GO_JOB_RUN_INDEX} --max-retries-count=3 --retry-only=retry-flaky run specs"
    end
  else
    sh "bundle exec gauge --tags '#{GAUGE_TAGS}' --max-retries-count=3 --retry-only=retry-flaky run specs"
  end
end
task default: %w[kill clean_all build_all prepare test]

task :setup_tfs_cli do
  rm_rf "tfs-tool"
  mkdir_p "tfs-tool"
  tee_clc_version = "14.139.0"
  sh "curl --compressed -sSL -H \"Authorization: token #{GITHUB_TOKEN}\" --output tfs-tool/TEE-CLC-#{tee_clc_version}.zip https://github.com/microsoft/team-explorer-everywhere/releases/download/#{tee_clc_version}/TEE-CLC-#{tee_clc_version}.zip"
  sh "unzip tfs-tool/TEE-CLC-#{tee_clc_version}.zip -d tfs-tool"
  sh "mv tfs-tool/TEE-CLC-#{tee_clc_version}/* tfs-tool/"
  cd "tfs-tool" do
    sh "yes | ./tf eula || true"
  end
end

namespace :db do
  desc 'task for starting postgres server if needed'
  task :prepare do
    db_mod = GO_PIPELINE_COUNTER % 5 # 1 H2 version and 4 postgres versions
    if db_mod === 0
      puts "Using h2..."
    else
      case db_mod
      when 1
        db_version = '14'
      when 2
        db_version = '15'
      when 3
        db_version = '16'
      else
        db_version = '17'
      end

      if DEVELOPMENT_MODE
        puts "Using postgres with locally installed postgres"
      else
        puts "Using postgres with version #{db_version}"

        [
            "/usr/pgsql-#{db_version}/bin/initdb /go/.pg-data",
            "echo \"unix_socket_directories = '/tmp'\" >> ~/.pg-data/postgresql.conf",
            "mkdir /go/.pg-data/log && /usr/pgsql-#{db_version}/bin/pg_ctl start -l /go/.pg-data/log/logfile -D /go/.pg-data -w -t 60"
        ].each do |command|
          system(command) || (puts "Failed to run command. Tried running: #{command}"; exit 1)
        end
      end
    end
  end
end
