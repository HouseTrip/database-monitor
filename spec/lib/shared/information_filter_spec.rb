require 'spec_helper'

module DatabaseMonitor
  describe InformationFilter do
    subject { described_class.new(db, info) }

    context 'Redis' do
      let(:relevant_attributes) { ['used_memory'] }
      let(:info) { RedisConnection.info }
      let(:db) { 'redis' }

      describe '#relevant_only' do
        it 'should filter the attributes on relevant source only' do
          subject.stub(:relevant_attributes).and_return(relevant_attributes)
          subject.relevant_only.keys.should == relevant_attributes
        end
      end
    end

    context 'Mongo' do
      let(:relevant_attributes) { ['dataSize'] }
      let(:info) { MongoConnection.db.stats }
      let(:db) { 'mongo' }

      describe '#relevant_only' do
        it 'should filter the attributes on relevant source only' do
          subject.stub(:relevant_attributes).and_return(relevant_attributes)
          subject.relevant_only.keys.should == relevant_attributes
        end
      end
    end
  end
end
