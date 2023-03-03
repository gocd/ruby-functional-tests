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
    DEFAULT_PLATFORMS = ['linux/amd64']

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
      @platforms = platforms_safe(image_info.first)
    end

    def has_image_count(target)
      target === image_count
    end

    def image_count
      images_for_current_platform.length
    end

    def image_info_at(position)
      image_info = images_for_current_platform[position]
      @image = image_info['imageName']
      @tag = image_info['tag']
      @file = image_info['file']
      @format = image_info['format']
      @platforms = platforms_safe(image_info)
    end

    def images_for_current_platform
      load_manifest.select { |image| platforms_safe(image).include?(docker_platform_for_current) }
    end

    private

    def platforms_safe(image_info)
      image_info['platforms'] || DEFAULT_PLATFORMS
    end

    def docker_platform_for_current
      "linux/#{RUBY_PLATFORM.split('-').first == 'arm64' ? 'arm64' : 'amd64'}"
    end
    
    def load_manifest
      raise "Docker image manifest file not available at #{@fldr}" unless File.exist?("#{@fldr}/manifest.json")
      JSON.parse(File.read("#{@fldr}/manifest.json"))
    end
  end
end