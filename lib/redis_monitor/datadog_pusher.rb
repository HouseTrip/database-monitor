class DataDogPusher

  def initialize(connection_options)
    @options = connection_options
  end

  def push(data)
    datadog.push(data)
  end

end
