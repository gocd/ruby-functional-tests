##########################################################################
# Copyright 2019 ThoughtWorks, Inc.
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

step 'Setup http based yum repo - setup' do
    yum_repo.create_new_repo_as("http_repo")
    p 'Created teh repo going to start the jetty server'
    yum_repo.start_jetty_server
end

step 'Setup http based yum repo - teardown' do
    yum_repo.stop_jetty_server
    yum_repo.remove_repo "http_repo"
end
