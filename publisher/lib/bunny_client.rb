class BunnyClient
  class << self
    def connect!
      @connection = Bunny.new(ENV['HOST_URL'])
      @connection.start

      @channel = @connection.create_channel
      @fan_out = @channel.fanout('notifications_email_out')

      @connected = true
    end

    def push(payload)
      connect! unless @connected
      @fan_out.publish(payload, { app_id: 'notifications_email' })

      true
    end
  end
end