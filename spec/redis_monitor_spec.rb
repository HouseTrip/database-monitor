require 'spec_helper'

describe "RedisMonitor" do
  it "should get information from Redis to DataDog" do
    redis_info = double
    RedisConnection.stub(:info).and_return(redis_info)
    filter_info = double
    RedisMonitor::InformationFilter.any_instance.stub(:relevant_only).and_return(filter_info)

    RedisConnection.should_receive(:info)
    RedisMonitor::InformationFilter.any_instance.should_receive(:relevant_only)
    RedisMonitor::DataDogPusher.any_instance.should_receive(:push).with(filter_info)

    RedisMonitor.run
  end

  it "should send to Datadog the correct attributes" do
    RedisMonitor::InformationFilter::CONFIG_FILE_NAME =
      File.expand_path('../fixtures/attributes.yml', __FILE__)

    %w(connected_clients used_memory used_memory_peak expired_keys evicted_keys).each do |key|
      DataDogClient.should_receive(:emit_point).with("redis.#{key}", anything)
    end

    RedisMonitor.run
  end
end
