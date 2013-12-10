require 'spec_helper'

module Watchdog
  describe InformationFilter do

    context 'Redis' do
      let(:relevant_attributes) { ['used_memory'] }
      let(:info) { RedisConnection.info }

      describe '#relevant_only' do
        it 'should filter the attributes on relevant source only' do
          filter = InformationFilter.new('redis', info)
          filter.stub(:relevant_attributes).and_return(relevant_attributes)
          filter.relevant_only.keys.should == relevant_attributes
        end
      end
    end

    context 'Mongo' do
      let(:relevant_attributes) { ['dataSize'] }
      let(:info) { MongoConnection.db.stats }

      describe '#relevant_only' do
        it 'should filter the attributes on relevant source only' do
          filter = InformationFilter.new('mongo', info)
          filter.stub(:relevant_attributes).and_return(relevant_attributes)
          filter.relevant_only.keys.should == relevant_attributes
        end
      end
    end
  end
end
