require 'yaml'

module RedisMonitor
  class InformationFilter

    def initialize(info)
      @info = info
    end

    def relevant_only
      @relevant_only ||=  @info.select { |key, value| relevant_attributes.include?(key) }
    end

    private

    def relevant_attributes
      @relevant_attributes = YAML.load(File.open File.expand_path('../../../config/relevant_attributes.yml', __FILE__))
    end

  end
end
