# #########################GO-LICENSE-START################################
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
# #########################GO-LICENSE-END##################################

require 'bundler/setup'
require 'childprocess'
require 'fileutils'
require 'sys-proctable'
require 'os'
require 'pry'
require 'json'
require 'open-uri'
include Sys

GO_TRUNK_DIRNAME = ENV['GO_TRUNK_DIR'] || 'gocd'
GO_PLUGINS_DIRNAME = ENV['GO_PLUGINS_DIR'] || 'go-plugins'
GO_JOB_RUN_COUNT = ENV['GO_JOB_RUN_COUNT']
GO_JOB_RUN_INDEX = ENV['GO_JOB_RUN_INDEX']
VERSION_NUMBER = ENV['GO_VERSION'] || (raise 'Environment variable GO_VERSION not set, exiting......')

GAUGE_TAGS = ENV['GAUGE_TAGS'] || 'smoke'
LOAD_BALANCED = GO_JOB_RUN_COUNT && GO_JOB_RUN_INDEX
DEVELOPMENT_MODE = !ENV['GO_PIPELINE_NAME']
USE_POSTGRESQL = !ENV['USE_POSTGRESQL'].nil?

ELASTICAGENTS_PLUGIN_RELEASE_URL = ENV['ELASTICAGENTS_PLUGIN_RELEASE_URL'] || 'https://api.github.com/repos/gocd-contrib/elastic-agent-skeleton-plugin/releases/latest'
JSON_CONFIG_PLUGIN_RELEASE_URL = ENV['JSON_CONFIG_PLUGIN_RELEASE_URL'] || 'https://api.github.com/repos/tomzo/gocd-json-config-plugin/releases/latest'
DOCKER_REGISTRY_ARTIFACT_PLUGIN_RELEASE_URL = ENV['DOCKER_REGISTRY_ARTIFACT_PLUGIN_RELEASE_URL'] || 'https://api.github.com/repos/gocd/docker-registry-artifact-plugin/releases'
TEST_EXTERNAL_ARTIFACTS_PLUGIN_RELEASE_URL = ENV['TEST_EXTERNAL_ARTIFACTS_PLUGIN_RELEASE_URL'] || 'https://api.github.com/repos/gocd-contrib/test-external-artifacts-plugin/releases/latest'
ANALYTICS_PLUGIN_DOWNLOAD_URL = ENV['ANALYTICS_PLUGIN_DOWNLOAD_URL']

desc 'cleans all directories'
task :clean_all do
  rm_rf 'target'
  rm_rf 'reports'
  mkdir_p 'target'
  if DEVELOPMENT_MODE
    cd "../#{GO_TRUNK_DIRNAME}" do
      sh './gradlew -q clean'
    end
    cd "../#{GO_PLUGINS_DIRNAME}" do
      sh 'mvn clean -q'
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

identifiers = { server: '-Dgo.gauge.server=true', agent: '-Dgo.gauge.agent=true', gauge: 'go_gauge' }

identifiers.each do |package, process_argument|
  namespace package do
    desc "Kill the #{package} identified using #{process_argument}"
    task :kill do
      if process = ProcTable.ps.find { |each_process| each_process.environ[process_argument] }
        $stderr.puts "Found PID(#{process.pid}) matching #{process_argument}"
        if OS.windows?
          sh("TASKKILL /PID #{process.pid}")
        else
          sh("kill -2 #{process.pid}")
        end

        sleep 2
        $stderr.puts "PID(#{process.pid}) exists after 2 seconds, force killing"
        if ProcTable.ps.find { |each_process| each_process.pid == process.pid }
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
        cp "config-files/server-logback.xml", "target/go-server-#{VERSION_NUMBER}/config/logback.xml"
      end
    end

    desc "Build go #{package}"
    task :build do
      Bundler.with_clean_env do
        cd "../#{GO_TRUNK_DIRNAME}" do
          sh "./gradlew -q #{package}GenericZip"
        end
      end
    end
  end
  task prepare: "#{package}:prepare"
end

namespace :plugins do
  desc 'copy the plugins in the go server'
  task :prepare do
    mkdir_p "target/go-server-#{VERSION_NUMBER}/plugins/external"
    mkdir_p "target/go-server-#{VERSION_NUMBER}/addons"
    if DEVELOPMENT_MODE
      cp_r "../#{GO_PLUGINS_DIRNAME}/target/go-plugins-dist/.", "target/go-server-#{VERSION_NUMBER}/plugins/external"
      cp_r "../#{GO_TRUNK_DIRNAME}/test/test-addon/target/libs/.", "target/go-server-#{VERSION_NUMBER}/addons"
    else
      cp_r 'target/go-plugins-dist/.', "target/go-server-#{VERSION_NUMBER}/plugins/external"

    end
    url = JSON.parse(open(ELASTICAGENTS_PLUGIN_RELEASE_URL).read)['assets'][0]['browser_download_url']
    sh "wget --quiet #{url} -O target/go-server-#{VERSION_NUMBER}/plugins/external/elastic-agent-skeleton-plugin.jar"
    url = JSON.parse(open(JSON_CONFIG_PLUGIN_RELEASE_URL).read)['assets'][0]['browser_download_url']
    sh "wget --quiet #{url} -O target/go-server-#{VERSION_NUMBER}/plugins/external/json-config-plugin.jar"
    url = JSON.parse(open(DOCKER_REGISTRY_ARTIFACT_PLUGIN_RELEASE_URL).read)[0]['assets'][0]['browser_download_url']
    sh "wget --quiet #{url} -O target/go-server-#{VERSION_NUMBER}/plugins/external/docker-registry-artifact-plugin.jar"
    url = JSON.parse(open(TEST_EXTERNAL_ARTIFACTS_PLUGIN_RELEASE_URL).read)['assets'][0]['browser_download_url']
    sh "wget --quiet #{url} -O target/go-server-#{VERSION_NUMBER}/plugins/external/dummy-artifact-plugin-0.0.1.jar"
  end

  desc 'task for preparing anlytics plugin'
  task :prepare_analytics do
    mkdir_p "target/go-server-#{VERSION_NUMBER}/plugins/external"
    sh "curl --silent --location -o target/go-server-#{VERSION_NUMBER}/plugins/external/analytics-plugin.jar --fail -H 'Accept: binary/octet-stream' --user '#{ENV['EXTENSIONS_USER']}:#{ENV['EXTENSIONS_PASSWORD']}' #{ANALYTICS_PLUGIN_DOWNLOAD_URL}"

    # preparing the database - drop and recreate analytics database
    
    ENV['ANALYTICS_DB_NAME_TO_USE'] = "#{ENV['ANALYTICS_DB_NAME'] || "analytics"}"
    ENV['POSTGRES_DB_HOST_TO_USE'] = "#{ENV['DB_HOST'] || "localhost"}"
  
  
    puts "Using DB: #{ENV['ANALYTICS_DB_NAME_TO_USE']} on host: #{ENV['POSTGRES_DB_HOST_TO_USE']}"
  
    db_user = ENV['DB_USER'] || 'postgres'
  
    drop_db_command = "java -jar tools/run_with_postgres.jar #{ENV['POSTGRES_DB_HOST_TO_USE']} 5432 postgres #{db_user} '' 'DROP DATABASE IF EXISTS #{ENV['ANALYTICS_DB_NAME_TO_USE']}'"
    create_db_command = "java -jar tools/run_with_postgres.jar #{ENV['POSTGRES_DB_HOST_TO_USE']} 5432 postgres #{db_user} '' 'CREATE DATABASE #{ENV['ANALYTICS_DB_NAME_TO_USE']}'"
    system("#{drop_db_command} && #{create_db_command}") || (puts "Failed to drop and recreate DB. Tried running: #{drop_db_command} && #{create_db_command}"; exit 1)
  
    puts "Recreated analytics DB: #{ENV['ANALYTICS_DB_NAME_TO_USE']}"
  end

  desc 'gradle build go plugins'
  task build: %i[version api] do
    cd "../#{GO_PLUGINS_DIRNAME}" do
      go_full_version = JSON.parse(File.read("../#{GO_TRUNK_DIRNAME}/installers/target/distributions/meta/version.json"))['go_full_version']
      sh "mvn --quiet --batch-mode package -Dgo.version=#{go_full_version} -DskipTests"
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

namespace :addons do
  desc 'copy the addons in the go server'
  task :prepare do
    mkdir_p 'target/test-addon'
    if DEVELOPMENT_MODE
      cp_r "../#{GO_TRUNK_DIRNAME}/test/test-addon/target/libs/.", "target/go-server-#{VERSION_NUMBER}/addons"
    else
      cp_r 'target/test-addon/.', "target/go-server-#{VERSION_NUMBER}/addons"
    end

    if USE_POSTGRESQL
      mv Dir.glob('target/*-addon/*.jar'), "target/go-server-#{VERSION_NUMBER}/addons"

      # Drop and recreate database for the test

      generated_db_name="#{ENV['DB_NAME_PREFIX']}__#{ENV['GO_JOB_NAME']}__#{ENV['GO_STAGE_NAME']}__#{ENV['GO_PIPELINE_NAME']}".gsub(/[^0-9a-zA-Z]/, "_")[0..62]
      ENV['POSTGRES_DB_NAME_TO_USE'] = "#{ENV['DB_NAME_PREFIX'] ? generated_db_name : "go"}"

      ENV['POSTGRES_DB_HOST_TO_USE'] = "#{ENV['DB_HOST'] || "localhost"}"
    
    
      puts "Using DB: #{ENV['POSTGRES_DB_NAME_TO_USE']} on host: #{ENV['POSTGRES_DB_HOST_TO_USE']}"
    
      db_user = ENV['DB_USER'] || 'postgres'
    
      drop_db_command = "java -jar tools/run_with_postgres.jar #{ENV['POSTGRES_DB_HOST_TO_USE']} 5432 postgres #{db_user} '' 'DROP DATABASE IF EXISTS #{ENV['POSTGRES_DB_NAME_TO_USE']}'"
      create_db_command = "java -jar tools/run_with_postgres.jar #{ENV['POSTGRES_DB_HOST_TO_USE']} 5432 postgres #{db_user} '' 'CREATE DATABASE #{ENV['POSTGRES_DB_NAME_TO_USE']}'"
      system("#{drop_db_command} && #{create_db_command}") || (puts "Failed to drop and recreate DB. Tried running: #{drop_db_command} && #{create_db_command}"; exit 1)
    
      puts "Recreated Postgresql DB: #{ENV['POSTGRES_DB_NAME_TO_USE']}"
    else
      p 'Not set to run with postgresql addon, proceeding with h2 database...'
    end

  end

  desc 'gradle build test addons'
  task :build do
    cd "../#{GO_TRUNK_DIRNAME}" do
      sh './gradlew -q test:test-addon:assemble'
    end
  end
end

desc 'Builds server, agent, plugins and test-addons if running in developement mode'
task :build_all do
  if DEVELOPMENT_MODE
    ['server:build', 'agent:build', 'plugins:build', 'addons:build'].each do |t|
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
    open(path, 'w') { |f| f.write(content) }
  end
end

desc 'initializes the filesystem to run tests'
task prepare: %w[plugins:prepare addons:prepare]

task :test do
  if LOAD_BALANCED
    sh "bundle exec gauge --tags '#{GAUGE_TAGS}' -n #{GO_JOB_RUN_COUNT} -g #{GO_JOB_RUN_INDEX} run specs"
  else
    sh "bundle exec gauge --tags '#{GAUGE_TAGS}' run specs"
  end
end
task default: %w[kill clean_all build_all prepare test]
