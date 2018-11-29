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
  class ScenarioState
    def initialize
      @scenario_store = Gauge::DataStoreFactory.scenario_datastore
      @scenario_store.put 'non-existing-pipeline', 'ghost-pipeline'
    end

    def get(key)
      @scenario_store.get key
    end

    def put(key, value)
      @scenario_store.put key, value
    end

   

    def self_pipeline
      @scenario_store.get(@scenario_store.get('current_pipeline'))
    end

    

    def material_revision(id)
      (@scenario_store.get id).nil? ? id : (@scenario_store.get id)
    end

    
  end
end
