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

step 'Using pipeline <pipeline> - setup' do |pipelines|
  pipelines.split(',').each { |pipeline|
    git_materials = Context::GitMaterials.new
    svn_materials = Context::SVNMaterials.new
    tfs_materials = Context::TFSMaterials.new

    git_count = git_materials.get_material_type_count(pipeline.strip)
    (0..git_count-1).each{|count|
      Context::GitMaterials.new.setup_material_for pipeline.strip, git_materials.get_material_url(pipeline.strip,count)
    }
    svn_materials.setup_material_for pipeline.strip if svn_materials.has_material_config?(pipeline.strip)
    tfs_materials.setup_material_for pipeline.strip if basic_configuration.has_material_of_type "tfs", pipeline.strip
  }
  basic_configuration.remove_pipelines_except pipelines.split(',').map(&:strip)
end

step 'Using pipeline with specific material <pipeline> - setup' do |pipelines|
  basic_configuration.remove_pipelines_except pipelines.split(',').map(&:strip)
end


step 'Using environment <environment> - setup' do |environments|
  environments.split(',').each { |env| scenario_state.put(env, env) }
  basic_configuration.remove_environments_except environments.split(',').map(&:strip)
end

step 'Remember current version as <identifier>' do |id|
  latest_revision = Context::GitMaterials.new(scenario_state.get("current_material_url")).latest_revision
  scenario_state.put id, latest_revision
end

step 'Modify and checkin file <file> as <user> with message <message>' do |file,user,message|
  Context::TFSMaterials.new.modify_and_checkin_tfs_file file,message
end
