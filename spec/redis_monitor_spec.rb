require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "RedisMonitor" do
  it "should work" do
    redis_info = double
    RedisConnection.stub(:info).and_return(redis_info)
    filter_info = double
    RedisMonitor::InformationFilter.any_instance.stub(:relevant_only).and_return(filter_info)

    RedisConnection.should_receive(:info)
    RedisMonitor::InformationFilter.any_instance.should_receive(:relevant_only)
    RedisMonitor::DataDogPusher.any_instance.should_receive(:push).with(filter_info)

    RedisMonitor.run
  end
end
