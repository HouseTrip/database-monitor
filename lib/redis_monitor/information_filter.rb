require 'yaml'

module RedisMonitor
  class InformationFilter
    CONFIG_FILE_NAME = File.expand_path('../../../config/relevant_attributes.yml', __FILE__)

    def initialize(info)
      @info = info
    end

    def relevant_only
      @relevant_only ||=  @info.select { |key, value| relevant_attributes.include?(key) }
    end

    private

    def relevant_attributes
      @relevant_attributes = YAML.load(File.open CONFIG_FILE_NAME)
    end

  end
end
