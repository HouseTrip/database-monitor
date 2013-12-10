require 'spec_helper'

describe Watchdog::RedisMonitor do
  let(:filter_info) { double }
  let(:filter) { double(:relevant_only => filter_info) }

  it 'should get information from Redis to DataDog' do
    Watchdog::InformationFilter.stub(:new => filter)

    Watchdog::DataDogPusher.should_receive(:push).with('redis', filter_info)

    Watchdog::RedisMonitor.run
  end

  it 'should send to Datadog the correct attributes' do
    Watchdog::InformationFilter.stub(:config_file_name =>
      File.expand_path('../../fixtures/attributes.yml', __FILE__))

    %w(connected_clients used_memory used_memory_peak expired_keys evicted_keys).each do |key|
      DataDogClient.should_receive(:emit_point).with("redis.#{key}", anything)
    end

    Watchdog::RedisMonitor.run
  end
end
