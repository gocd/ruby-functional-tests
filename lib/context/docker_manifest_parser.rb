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
    MANIFEST = "manifest.json"

    attr_reader :image
    attr_reader :tag
    attr_reader :file
    attr_reader :format
    attr_reader :platforms

    def initialize(fldr)
      @fldr = fldr
      @manifest = "#{@fldr}/#{MANIFEST}"
      raise "Manifest [#{@manifest}] not found, or in invalid folder" unless @fldr&.length > 2 and File.exist?(@manifest)
    end

    def has_image_count?(target)
      target === image_count
    end

    def image_count
      images_for_current_platform.length
    end

    def select_image_info_at(position)
      image_info = images_for_current_platform[position]
      @image = image_info['imageName']
      @tag = image_info['tag']
      @file = image_info['file']
      @format = image_info['format']
      @platforms = platforms_safe(image_info)
      raise "Selected file [#{@file}] not found in folder [#{@fldr}]" unless File.exist?("#{@fldr}/#{@file}")

      clean_non_selected_artifacts
      self
    end

    def clean_artifacts
      Dir.children(@fldr).each do |name|
        next if name == MANIFEST
        File.delete "#{@fldr}/#{file}"
      end
    end

    def clean_folder
      sh %(rm -rf #{@fldr})
    end

    private

    def clean_non_selected_artifacts
      Dir.children(@fldr).each do |name|
        next if name == MANIFEST or name == @file
        File.delete "#{@fldr}/#{file}"
      end unless @file.nil?
    end

    def images_for_current_platform
      load_manifest.select { |image| platforms_safe(image).any? { |platform| platform.start_with?(docker_platform_for_local_arch) } }
    end

    def platforms_safe(image_info)
      image_info['platforms'] || DEFAULT_PLATFORMS
    end

    def docker_platform_for_local_arch
      "linux/#{local_arch_is_arm ? 'arm64' : 'amd64'}"
    end

    def local_arch_is_arm
      RUBY_PLATFORM =~ /aarch64|arm64/
    end

    def load_manifest
      raise "Docker image manifest file not available at #{@fldr}" unless File.exist?(@manifest)
      JSON.parse(File.read(@manifest))
    end
  end
end