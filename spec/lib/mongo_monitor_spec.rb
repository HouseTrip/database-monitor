require 'spec_helper'

describe Watchdog::MongoMonitor do
  it 'should get information from Mongo to DataDog' do
    redis_info = double
    MongoConnection.stub_chain(:db, :stats).and_return(redis_info)
    filter_info = double
    Watchdog::InformationFilter.any_instance.stub(:relevant_only).and_return(filter_info)

    MongoConnection.should_receive(:db)
    Watchdog::InformationFilter.any_instance.should_receive(:relevant_only)
    Watchdog::DataDogPusher.any_instance.should_receive(:push).with('mongo', filter_info)

    Watchdog::MongoMonitor.run
  end

  it 'should send to Datadog the correct attributes' do
    Watchdog::InformationFilter.stub(:config_file_name =>
      File.expand_path('../../fixtures/attributes.yml', __FILE__))

    %w(objects avgObjSize dataSize).each do |key|
      DataDogClient.should_receive(:emit_point).with("mongo.#{key}", anything)
    end

    Watchdog::MongoMonitor.run
  end
end
