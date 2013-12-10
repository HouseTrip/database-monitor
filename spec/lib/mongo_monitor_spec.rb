require 'spec_helper'

describe Watchdog::MongoMonitor do
  let(:stats) { { 'objects' => 3, 'avgObjSize' => 1000, 'dataSize' => 12893 } }
  let(:mongo_info) { double(:stats => stats, :name => 'name') }

  before(:each) do
    MongoConnection.stub(:db => mongo_info)
  end

  it 'should get information from Mongo to DataDog' do
    filter_info = double
    Watchdog::InformationFilter.any_instance.stub(:relevant_only).and_return(filter_info)

    MongoConnection.should_receive(:db)
    Watchdog::InformationFilter.any_instance.should_receive(:relevant_only)
    Watchdog::DataDogPusher.any_instance.should_receive(:push).with('mongo.name', filter_info)

    Watchdog::MongoMonitor.run
  end

  it 'should send to Datadog the correct attributes' do
    Watchdog::InformationFilter.stub(:config_file_name =>
      File.expand_path('../../fixtures/attributes.yml', __FILE__))

    %w(objects avgObjSize).each do |key|
      DataDogClient.should_receive(:emit_point).with("mongo.name.#{key}", anything)
    end

    Watchdog::MongoMonitor.run
  end
end
