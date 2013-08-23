require 'spec_helper'

module RedisMonitor
  describe InformationFilter do

    let(:relevant_attributes) { ["used_memory"] }
    let(:info) { RedisConnection.info }

    describe "#relevant_only" do
      it "should filter the attributes on relevant source only" do
        filter = InformationFilter.new(info)
        filter.stub(:relevant_attributes).and_return(relevant_attributes)
        filter.relevant_only.keys.should == relevant_attributes
      end
    end

  end
end
