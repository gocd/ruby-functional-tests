##########################################################################
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
##########################################################################

require 'open3'


module Context

  class Materials
    include FileUtils
  end

  class GitMaterials < Materials

    def initialize(*_args)
      @path = "#{GoConstants::TEMP_DIR}/gitmaterial-#{Time.now.to_i}"
    end

    def setup_material_for(pipeline)
      rm_rf(@path)
      mkdir_p(@path)
      cd(@path) do
        Open3.popen3('git init sample.git') do |_stdin, _stdout, stderr, wait_thr|
          raise "Initialization of git Material Failed. Error returned: #{stderr.read}" unless wait_thr.value.success?
        end
      end
      initial_commit
      basic_configuration.set_material_path_for_pipeline(pipeline, "#{@path}/sample.git")
    end

    def initial_commit
      cp_r "resources/Rakefile", "#{@path}/sample.git/"
      cd("#{@path}/sample.git") do
        Open3.popen3(%(git add . && git commit -m "Commit the test rakefile")) do |_stdin, _stdout, stderr, wait_thr|
          raise "Failed to commit to git repository. Error returned: #{stderr.read}" unless wait_thr.value.success?
        end
      end
    end

    def create_stopjob(filename)
      go_agents.get_working_dirs.each{|agent_dir| sh("touch #{agent_dir}/#{filename}")}
    end
  end

  class ConfigRepoMaterial < Materials

    attr_reader :path
    attr_reader :pipeline_name

    def initialize(*_args)
    end

    def setup(pipeline, repo, upstream)
      @path = "#{GoConstants::TEMP_DIR}/gitconfig-#{Time.now.to_i}"
      @pipeline_name = "#{pipeline}-#{SecureRandom.hex(4)}"
      rm_rf(@path)
      mkdir_p(@path)
      cd(@path) do
        Open3.popen3('git init config_repo.git') do |_stdin, _stdout, stderr, wait_thr|
          raise "Initialization of git Config repository material Failed. Error returned: #{stderr.read}" unless wait_thr.value.success?
        end
      end
      create_pipeline("#{@path}/config_repo.git", upstream)
      basic_configuration.set_config_repo("#{@path}/config_repo.git", repo)
      scenario_state.add_pipeline pipeline, @pipeline_name
      scenario_state.add_configrepo pipeline, self
    end

    def create_pipeline(material, upstream)
      pipeline = Pipeline.new(group: 'configrepo', name: "#{@pipeline_name}") do |p|
        p << GitMaterial.new(url: "#{material}", name: "gitmaterial")
        p << DependencyMaterial.new(pipeline: "#{scenario_state.get_pipeline(upstream)}") unless upstream.empty?
        p << Stage.new(name: 'defaultStage') do |s|
          s << Job.new(name: 'defaultJob') do |j|
            j << ExecTask.new(command: 'ls')
          end
        end
      end

      cd(material) do
        File.open("#{@pipeline_name}.gopipeline.json", 'w') { |file| file.write(pipeline.to_json) }
        Open3.popen3(%(git add . && git commit -m "created a new pipeline")) do |_stdin, _stdout, stderr, wait_thr|
          raise "Failed to commit to git config repository. Error returned: #{stderr.read}" unless wait_thr.value.success?
        end
      end

    end

    def update_pipeline(upstream)
      pipeline = Pipeline.new(group: 'configrepo', name: "#{@pipeline_name}") do |p|
        p << GitMaterial.new(url: "#{@path}/config_repo.git", name: "gitmaterial")
        p << DependencyMaterial.new(pipeline: "#{scenario_state.get_pipeline(upstream)}")
        p << Stage.new(name: 'defaultStage') do |s|
          s << Job.new(name: 'defaultJob') do |j|
            j << ExecTask.new(command: 'ls')
          end
        end
      end

      cd("#{@path}/config_repo.git") do
        File.open("#{@pipeline_name}.gopipeline.json", 'w') { |file| file.write(pipeline.to_json) }
        Open3.popen3(%(git add . && git commit -m "updated the pipeline")) do |_stdin, _stdout, stderr, wait_thr|
          raise "Failed to commit to git config repository. Error returned: #{stderr.read}" unless wait_thr.value.success?
        end
      end

    end

  end

  class ConfigRepoEnvironment < Materials

    attr_reader :path
    attr_reader :environment_name

    def initialize(*_args)
      @pipelines = Array.new
    end


    def setupExisting(environment, repo)
      create_repo(environment, environment, repo)
    end

    def setup(environment, repo)
      create_repo(environment, "#{environment}-#{SecureRandom.hex(4)}", repo)
    end

    def create_environment(material)
      environment = Environment.new(@environment_name, @pipelines)
      add_environment_to_config_repo(environment, material)
    end

    def add_pipeline(pipeline)
      @pipelines.push(pipeline)
      environment = Environment.new(@environment_name, @pipelines)
      add_environment_to_config_repo(environment, "#{@path}/config_repo.git")
    end

    private
    def add_environment_to_config_repo(environment, material)
      cd(material) do
        File.open("#{@environment_name}.goenvironment.json", 'w') { |file| file.write(environment.to_json) }
        Open3.popen3(%(git add . && git commit -m "created a new environment")) do |_stdin, _stdout, stderr, wait_thr|
          raise "Failed to commit to git config repository. Error returned: #{stderr.read}" unless wait_thr.value.success?
        end
      end
    end

    def create_repo(environment, environment_unique_name, repo)
      @path = "#{GoConstants::TEMP_DIR}/gitconfig-#{Time.now.to_i}"
      @environment_name = environment_unique_name
      rm_rf(@path)
      mkdir_p(@path)
      cd(@path) do
        Open3.popen3('git init config_repo.git') do |_stdin, _stdout, stderr, wait_thr|
          raise "Initialization of git Config repository material Failed. Error returned: #{stderr.read}" unless wait_thr.value.success?
        end
      end
      create_environment("#{@path}/config_repo.git")
      basic_configuration.set_config_repo("#{@path}/config_repo.git", repo)
      scenario_state.add_environment environment, @environment_name
      scenario_state.add_configrepo environment, self
    end

  end
end
