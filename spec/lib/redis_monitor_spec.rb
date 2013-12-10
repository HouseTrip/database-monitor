require 'spec_helper'

describe Watchdog::RedisMonitor do
  it "should get information from Redis to DataDog" do
    redis_info = double
    RedisConnection.stub(:info).and_return(redis_info)
    filter_info = double
    Watchdog::InformationFilter.any_instance.stub(:relevant_only).and_return(filter_info)

    RedisConnection.should_receive(:info)
    Watchdog::InformationFilter.any_instance.should_receive(:relevant_only)
    Watchdog::DataDogPusher.any_instance.should_receive(:push).with('redis', filter_info)

    Watchdog::RedisMonitor.run
  end

  it "should send to Datadog the correct attributes" do
    Watchdog::InformationFilter.stub(:config_file_name =>
      File.expand_path('../../fixtures/attributes.yml', __FILE__))

    %w(connected_clients used_memory used_memory_peak expired_keys evicted_keys).each do |key|
      DataDogClient.should_receive(:emit_point).with("redis.#{key}", anything)
    end

    Watchdog::RedisMonitor.run
  end
end
