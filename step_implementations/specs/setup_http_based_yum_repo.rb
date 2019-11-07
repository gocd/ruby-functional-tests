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
    # Setup some yum repos based on what is there in the cruise config
    # Cruise config will be updated with some random names like `http://localhost:8081/pkgrepo-<rnd_value>`
    # So need to read from cruise config how many repos are needed - whats the random names given to them
    # and create repos according to that name
    yumrepo.create_new_repo_as("name_got_from_cruise_config")
end

step 'Setup http based yum repo - teardown' do
    # Remove all the repos setup as per the values in cruise config xml
end
