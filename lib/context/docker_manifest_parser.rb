##########################################################################
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
##########################################################################
module Context
  class DockerManifestParser
    attr_reader :image
    attr_reader :tag
    attr_reader :file
    attr_reader :format
    attr_reader :platforms

    def initialize(fldr)
      @fldr = fldr
    end

    def image_info_of(os)
      image_info = load_manifest.select { |image| image['imageName'].include? os }
      raise "No image for OS #{os} available" if image_info.nil?
      @image = image_info.first['imageName']
      @tag = image_info.first['tag']
      @file = image_info.first['file']
      @format = image_info.first['format']
      @platforms = image_info.first['platforms'] || []
    end

    def has_image_count(target)
      target === image_count
    end

    def image_count
      load_manifest.length
    end

    def image_info_at(position)
      image_info = load_manifest[position]
      @image = image_info['imageName']
      @tag = image_info['tag']
      @file = image_info['file']
      @format = image_info['format']
      @platforms = image_info['platforms'] || []
    end

    def load_manifest
      raise "Docker image manifest file not available at #{@fldr}" unless File.exist?("#{@fldr}/manifest.json")
      JSON.parse(File.read("#{@fldr}/manifest.json"))
    end
  end
end