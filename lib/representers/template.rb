require 'roar/decorator'
require 'roar/json'
require 'roar/client'

module Representers

  class Stage < OpenStruct
  end

  class Job < OpenStruct
  end

  class Task < OpenStruct
  end

  class Attributes < OpenStruct
  end

  class Template < OpenStruct
  end

  class TemplateRepresenter < Roar::Decorator
    include Roar::JSON

    property :name
    collection :stages, class: Stage do
      property :name, default: "defaultStage"
      property :fetch_materials, default: true
      property :clean_working_directory, default: false
      property :never_cleanup_artifacts, default: false
      collection :environment_variables, default: []
      collection :jobs, class: Job do
        property :name, default: "defaultJob"
        property :run_instance_count, default: "null"
        property :elastic_profile_id, default: "null"
        property :timeout, default: 0
        collection :environment_varaible, default: []
        collection :resources, default: []
        collection :tasks, class: Task do
          property :type, default: "exec"
          property :attributes do
            property :command, default: "ls"
            property :working_directory, default: "null"
          end
        end
      end
    end
  end
  
end
