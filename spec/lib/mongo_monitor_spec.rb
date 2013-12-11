require 'spec_helper'

describe DatabaseMonitor::MongoMonitor do
  let(:stats) { { 'objects' => 3, 'avgObjSize' => 1000, 'dataSize' => 12893 } }
  let(:mongo_info) { double(:stats => stats, :name => 'name') }
  let(:filter_info) { double }
  let(:filter) { double(:relevant_only => filter_info) }

  before(:each) do
    MongoConnection.stub(:db => mongo_info)
  end

  it 'should get information from Mongo to DataDog' do
    DatabaseMonitor::InformationFilter.stub(:new => filter)

    DatabaseMonitor::DataDogPusher.should_receive(:push).with('mongo.name', filter_info)

    DatabaseMonitor::MongoMonitor.run
  end

  it 'should send to Datadog the correct attributes' do
    DatabaseMonitor::InformationFilter.stub(:config_file_name =>
      File.expand_path('../../fixtures/attributes.yml', __FILE__))

    %w(objects avgObjSize).each do |key|
      DataDogClient.should_receive(:emit_point).with("mongo.name.#{key}", anything)
    end

    DatabaseMonitor::MongoMonitor.run
  end
end
