require 'yaml'

module Watchdog
  class InformationFilter
    def initialize(type, info)
      @type = type
      @info = info
    end

    def relevant_only
      @relevant_only ||=  @info.select { |key, value| relevant_attributes.include?(key) }
    end

    private

    def relevant_attributes
      @relevant_attributes = YAML.load(File.open self.class.config_file_name)[@type]
    end

    def self.config_file_name
      File.expand_path('../../../../config/relevant_attributes.yml', __FILE__)
    end
  end
end
