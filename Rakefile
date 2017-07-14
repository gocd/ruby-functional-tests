# #########################GO-LICENSE-START################################
# Copyright 2016 ThoughtWorks, Inc.
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
include Sys

GO_TRUNK_DIRNAME = ENV['GO_TRUNK_DIR'] || 'gocd'
GO_PLUGINS_DIRNAME = ENV['GO_PLUGINS_DIR'] || 'go-plugins'
GO_JOB_RUN_COUNT = ENV['GO_JOB_RUN_COUNT']
GO_JOB_RUN_INDEX = ENV['GO_JOB_RUN_INDEX']
VERSION_NUMBER = ENV['GO_VERSION'] || (raise 'Environment variable GO_VERSION not set, exiting......')

GAUGE_TAGS = ENV['GAUGE_TAGS'] || 'smoke'
LOAD_BALANCED = GO_JOB_RUN_COUNT && GO_JOB_RUN_INDEX
DEVELOPMENT_MODE = !ENV['GO_PIPELINE_NAME']

desc 'cleans all directories'
task :clean_all do
  rm_rf 'target'
  rm_rf 'reports'
  mkdir_p 'target'
  if DEVELOPMENT_MODE
    cd "../#{GO_TRUNK_DIRNAME}" do
      sh "./gradlew -q clean"
    end
    cd "../#{GO_PLUGINS_DIRNAME}" do
      sh "mvn clean -q"
    end
  end
end

desc 'cleans only test directories'
task :clean_test do
  rm_rf 'target'
  rm_rf 'reports'
  mkdir_p 'target'
end

zips = %w(server agent).each_with_object({}) do |package, accumulator|
  accumulator[package] = if DEVELOPMENT_MODE
                           Dir[File.join('..', GO_TRUNK_DIRNAME, 'installers', 'target', 'distributions', 'zip', "go-#{package}*.zip")].first
                         else
                           Dir[File.join('target', 'zip', "go-#{package}*.zip")].first
                         end

  accumulator
end

identifiers = {server: '-Dgo.gauge.server', agent: '-Dgo.gauge.agent', gauge: 'go_gauge'}

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
    if DEVELOPMENT_MODE
      cp_r "../#{GO_PLUGINS_DIRNAME}/target/go-plugins-dist/.", "target/go-server-#{VERSION_NUMBER}/plugins/external"
    else
      cp_r 'target/go-plugins-dist/.', "target/go-server-#{VERSION_NUMBER}/plugins/external"
    end
    cp_r 'plugins/.', "target/go-server-#{VERSION_NUMBER}/plugins/external"
    rm "target/go-server-#{VERSION_NUMBER}/plugins/external/yum-repo-exec-poller.jar"
  end

  desc 'gradle build go plugins'
  task :build => [:version, :api] do
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
      sh "./gradlew -q go-plugin-api:install go-plugin-api-internal:install"
    end
  end
end

namespace :addons do
  desc 'copy the addons in the go server'
  task :prepare do
    mkdir_p 'target/test-addon'
    if DEVELOPMENT_MODE
      cp_r "../#{GO_TRUNK_DIRNAME}/test-addon/target/libs/.", "target/go-server-#{VERSION_NUMBER}/addons"
    else
      cp_r 'target/test-addon/.', "target/go-server-#{VERSION_NUMBER}/addons"
    end
  end

  desc 'gradle build test addons'
  task :build do
    cd "../#{GO_TRUNK_DIRNAME}" do
      sh "./gradlew -q test-addon:assemble"
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

  raise "Please provide VERSION" if version.empty?
  Dir["./resources/config/*.xml"].each do |path|
    content = File.read(path)
    if content =~ /xsi:noNamespaceSchemaLocation="cruise-config.xsd"/
      puts "Replacing content in #{path}"
      content = content.gsub(/schemaVersion="\d+"/, %Q{schemaVersion="#{version}"})
      open(path, 'w') {|f| f.write(content)}
    end
  end
end

desc 'initializes the filesystem to run tests'
task prepare: %w(plugins:prepare addons:prepare)

task :test do
  if LOAD_BALANCED
    sh "bundle exec gauge --tags='#{GAUGE_TAGS}' -n=#{GO_JOB_RUN_COUNT} -g=#{GO_JOB_RUN_INDEX} specs"
  else
    sh "bundle exec gauge --tags='#{GAUGE_TAGS}' specs"
  end
end
task default: %w(kill clean_all build_all prepare test)
