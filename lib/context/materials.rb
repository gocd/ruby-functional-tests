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
module Context
  class Materials
    include FileUtils

    attr_reader :material_type

    def has_material_config?(pipeline_name)
      return material_config(pipeline_name).first.value.start_with?('material-for') unless material_config(pipeline_name).empty?
      return false
    end

    def material_config(pipeline)
      current_configuration = basic_configuration.get_config_from_server
      current_configuration.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.get(pipeline)}']/materials/#{@material_type}/@url")
    end

    def get_material_type_count(pipeline)
      current_configuration = basic_configuration.get_config_from_server
      current_configuration.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.get(pipeline)}']/materials/#{@material_type}/@url").count
    end

    def get_material_url(pipeline,count)
      current_configuration = basic_configuration.get_config_from_server
      return current_configuration.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.get(pipeline)}']/materials/#{@material_type}/@url")[count].value
    end

    def modify_and_checkin_tfs_file(file_name,message)
      cd(scenario_state.get('repository_directory')) do
        Open3.popen3("#{scenario_state.get('tfs_tool_path')} checkout * -recursive -login:#{ENV['TFS_SERVER_USERNAME']},#{ENV['TFS_SERVER_PASSWORD']}") do |_stdin, _stdout, stderr, wait_thr|
          raise "checkout of tfs material Failed. Error returned: #{stderr.read}" unless wait_thr.value.success?
         end
      end
      cd(scenario_state.get('repository_directory')) do
        File.open(file_name, 'w') { |file| file.write("adding text  #{Time.now.to_i}-#{SecureRandom.hex(4)}") }
        Open3.popen3("#{scenario_state.get('tfs_tool_path')} checkin -comment:\"#{message}\" -noprompt -login:#{ENV['TFS_SERVER_USERNAME']},#{ENV['TFS_SERVER_PASSWORD']}") do |_stdin, _stdout, stderr, wait_thr|
          raise "checkin Failed. Error returned: #{stderr.read}" unless wait_thr.value.success?
         end
      end
    end

  end

  class GitMaterials < Materials
    attr_reader :path

    def initialize(path = "#{GoConstants::TEMP_DIR}/gitmaterial-#{Time.now.to_i}-#{SecureRandom.hex(4)}", type = 'git')
      @path = path
      @material_type = type
    end

    def setup_material_for(pipeline,material_url)
      if !scenario_state.get(material_url).nil?
        material_path = scenario_state.get(material_url)
      else
        rm_rf(@path)
        mkdir_p(@path)
        cd(@path) do
          Open3.popen3('git init sample.git') do |_stdin, _stdout, stderr, wait_thr|
            raise "Initialization of git Material Failed. Error returned: #{stderr.read}" unless wait_thr.value.success?
          end
        end
        initial_commit
        material_path = "#{@path}/sample.git"
        scenario_state.put(material_url, material_path)
      end
      basic_configuration.set_material_path_for_pipeline('git', pipeline, material_path,material_url)
    rescue StandardError => e
      raise "The Pipeline #{pipeline} setup for GIT material failed. #{e.message}"
    end

    def initial_commit
      cp_r 'resources/Rakefile', "#{@path}/sample.git/"
      cd("#{@path}/sample.git") do
        Open3.popen3(%(git add . && git commit -m "Commit the test rakefile")) do |_stdin, _stdout, stderr, wait_thr|
          raise "Failed to commit to git repository. Error returned: #{stderr.read}" unless wait_thr.value.success?
        end
      end
    end

    def new_commit(filename, commit, author = 'gouser')
      cd(@path.to_s) do
        sh "touch #{filename}"
        Open3.popen3(%(git add . && git commit --author="#{author} <user@go>" -m "#{commit}")) do |_stdin, _stdout, stderr, wait_thr|
          raise "Failed to commit to git repository. Error returned: #{stderr.read}" unless wait_thr.value.success?
        end
      end
    end

    def create_new_directory_and_add_file(filename,directory_name)
        mkdir_p("#{@path.to_s}/#{directory_name}")
          if File.exist?("resources/#{filename}")
            cp_r "resources/#{filename}" ,"#{@path.to_s}/#{directory_name}"
          else
            sh "touch #{@path.to_s}/#{directory_name}/#{filename}"
          end
        cd ("#{@path.to_s}/#{directory_name}") do
        Open3.popen3(%(git add . && git commit -m "Adding new file #{filename} in #{directory_name}")) do |_stdin, _stdout, stderr, wait_thr|
          raise "Failed to commit to git repository. Error returned: #{stderr.read}" unless wait_thr.value.success?
        end
      end
    end

    def latest_revision
      cd(@path.to_s) do
        stdout, _stdeerr, _status = Open3.capture3(%(git rev-parse HEAD))
        return stdout.delete("\n")
      end
    end

    def nth_revision rev
      cd(@path.to_s) do
        stdout, _stdeerr, _status = Open3.capture3(%(git rev-parse HEAD~#{rev}))
        return stdout.delete("\n")
      end
    end

    def auther_name rev
      cd(@path.to_s) do
        stdout, _stdeerr, _status = Open3.capture3(%(git --no-pager show -s --format='%an <%ae>' #{rev}))
        return stdout.delete("\n")
      end
    end

  end

  class SVNMaterials < Materials
    attr_reader :repository_directory
    attr_reader :working_copy
    attr_reader :repo_uuid

    def initialize(repo_dir = "#{GoConstants::TEMP_DIR}/svn_repo_dir-#{Time.now.to_i}-#{SecureRandom.hex(4)}",
                   working_copy = "#{GoConstants::TEMP_DIR}/svn_wrk_copy-#{Time.now.to_i}-#{SecureRandom.hex(4)}",
                   type = 'svn')
      @repository_directory = repo_dir
      @working_copy = working_copy
      @material_type = type
    end

    def setup_material_for(pipeline)
      material_url = material_config(pipeline).first.value
      if !scenario_state.get(material_url).nil?
        material_path = scenario_state.get(material_url)
      else
        rm_rf(@repository_directory)
        mkdir_p(@repository_directory)
        cp_r('test-repos/svn_repos/end2end/', @repository_directory)
        cd(@repository_directory) do
          Open3.popen3("svn checkout file://#{@repository_directory}/end2end #{@working_copy}") do |_stdin, _stdout, stderr, wait_thr|
            raise "SVN Material Checkout to working directory Failed. Error returned: #{stderr.read}" unless wait_thr.value.success?
          end
          stdout, _stdeerr, _status = Open3.capture3(%(svnlook uuid #{@repository_directory}))
          @repo_uuid = stdout.delete("\n")
        end
        initial_commit
        material_path = "file://#{@repository_directory}/end2end"
        scenario_state.put(material_url, material_path)
      end
      basic_configuration.set_material_path_for_pipeline('svn', pipeline, material_path)
    rescue StandardError => e
      raise "The Pipeline #{pipeline} setup for SVN material failed. #{e.message}"
    end

    def initial_commit
      cp_r 'resources/Rakefile', "#{@working_copy}/"
      cd(@working_copy) do
        Open3.popen3(%(svn add Rakefile && svn ci --non-interactive --username gouser -m "Commit the test rakefile")) do |_stdin, _stdout, stderr, wait_thr|
          raise "Failed to commit to SVN repository. Error returned: #{stderr.read}" unless wait_thr.value.success?
        end
      end
    end

    def new_commit(filename, commit, author = 'gouser')
      cd(@working_copy.to_s) do
        sh "touch #{filename}"
        Open3.popen3(%(svn add #{filename} && svn ci --non-interactive --username "#{author} <user@go>" -m "#{commit}")) do |_stdin, _stdout, stderr, wait_thr|
          raise "Failed to commit to SVN repository. Error returned: #{stderr.read}" unless wait_thr.value.success?
        end
      end
    end

    def latest_revision
      cd(@working_copy.to_s) do
        stdout, _stdeerr, _status = Open3.capture3(%(svn info -r HEAD))
        return stdout.delete("\n")
      end
    end
  end

  class TFSMaterials < Materials
    attr_reader :workspace_name
    attr_reader :material_type
    attr_reader :repository_directory
    attr_reader :tfs_tool_path
    def initialize(workspace = "test_workspace_#{Time.now.to_i}-#{SecureRandom.hex(4)}",
      repo_folder_path="#{GoConstants::TEMP_DIR}/test_tfs_Folder_#{Time.now.to_i}-#{SecureRandom.hex(4)}",
      tfs_tool=File.expand_path("tfs-tool/tf"),
      type='tfs')
       @workspace_name = workspace
       @repository_directory = repo_folder_path
       @material_type = type
       @tfs_tool_path=tfs_tool
    end

    def setup_material_for(pipeline)
      current_configuration = basic_configuration.get_config_from_server
      tfs_url=current_configuration.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.get(pipeline)}']/materials/tfs/@url")
      tfs_username=current_configuration.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.get(pipeline)}']/materials/tfs/@username")
      tfs_password=current_configuration.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.get(pipeline)}']/materials/tfs/@password")
      tfs_project_path=current_configuration.xpath("//cruise/pipelines/pipeline[@name='#{scenario_state.get(pipeline)}']/materials/tfs/@projectPath")
      rm_rf(@repository_directory)
      mkdir_p(@repository_directory)
       cd(@repository_directory) do
        chmod 0755,@tfs_tool_path
         Open3.popen3("#{@tfs_tool_path} workspace -new -noprompt -server:#{ENV['TFS_SERVER_URL'] } -login:#{ENV['TFS_SERVER_USERNAME']},#{ENV['TFS_SERVER_PASSWORD']}  #{@workspace_name}") do |_stdin, _stdout, stderr, wait_thr|
          raise "Initialization of tfs workspece Failed. Error returned: #{stderr.read}" unless wait_thr.value.success?
         end
         Open3.popen3("#{@tfs_tool_path} workfold -map -workspace:#{@workspace_name} -server:#{ENV['TFS_SERVER_URL'] } -login:#{ENV['TFS_SERVER_USERNAME']},#{ENV['TFS_SERVER_PASSWORD']}  #{tfs_project_path} #{@repository_directory}") do |_stdin, _stdout, stderr, wait_thr|
          raise "Mapping of tfs workspece Failed. Error returned: #{stderr.read}" unless wait_thr.value.success?
         end
         Open3.popen3("#{@tfs_tool_path} get #{@repository_directory} -recursive -noprompt -all -server:#{ENV['TFS_SERVER_URL'] } -login:#{ENV['TFS_SERVER_USERNAME']},#{ENV['TFS_SERVER_PASSWORD']}  #{tfs_project_path}") do |_stdin, _stdout, stderr, wait_thr|
          raise "Getting of tfs material Failed. Error returned: #{stderr.read}" unless wait_thr.value.success?
         end
         Open3.popen3("#{@tfs_tool_path} checkout * -recursive -login:#{ENV['TFS_SERVER_USERNAME']},#{ENV['TFS_SERVER_PASSWORD']}") do |_stdin, _stdout, stderr, wait_thr|
          raise "checkoutf of tfs material Failed. Error returned: #{stderr.read}" unless wait_thr.value.success?
         end
         basic_configuration.set_material_path_for_tfs_pipeline(pipeline, ENV['TFS_SERVER_URL'],ENV['TFS_SERVER_USERNAME'],ENV['TFS_SERVER_PASSWORD'])
         scenario_state.put('workspace',@workspace_name)
         scenario_state.put('repository_directory',@repository_directory)
         scenario_state.put('tfs_tool_path',@tfs_tool_path)
         scenario_state.put('tfs_project_path',tfs_project_path)
       end
    end
  end

  class ConfigRepoMaterial < Materials
    attr_reader :path
    attr_reader :pipeline_name

    def initialize(*_args); end

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
      scenario_state.put pipeline, @pipeline_name
      scenario_state.put("#{pipeline}-configrepo", self)
    end

    def create_pipeline(material, upstream)
      pipeline = Pipeline.new(group: 'configrepo', name: @pipeline_name.to_s) do |p|
        p << GitMaterial.new(url: material.to_s, name: 'gitmaterial')
        p << DependencyMaterial.new(pipeline: scenario_state.get(upstream).to_s) unless upstream.empty?
        p << Stage.new(name: 'defaultStage') do |s|
          s << Job.new(name: 'defaultJob') do |j|
            j << ExecTask.new(command: 'sleep', arguments: ['10'])
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
      pipeline = Pipeline.new(group: 'configrepo', name: @pipeline_name.to_s) do |p|
        p << GitMaterial.new(url: "#{@path}/config_repo.git", name: 'gitmaterial')
        p << DependencyMaterial.new(pipeline: scenario_state.get(upstream).to_s)
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
      @pipelines = []
    end

    def setup_existing(environment, repo)
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
      scenario_state.put environment, @environment_name
      scenario_state.put("#{environment}-configrepo", self)
    end
  end
end
