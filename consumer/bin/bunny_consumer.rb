#!/usr/bin/env ruby

require File.expand_path('../config/environment', __dir__)

connection = Bunny.new(ENV['HOST_URl'])
connection.start
channel = connection.create_channel

queue = channel.queue('notifications_email.in', durable: true, auto_delete: false)

puts "\nStarting consumer!"

fanout_name = 'notifications_email.out'
queue.bind(channel.exchange(fanout_name, type: 'fanout'))

puts "[consumer] #{queue.name} binds to #{fanout_name}"

queue.subscribe do |d_info, properties, payload|
    puts "Recebido: #{payload}"

    Email.create_and_send(JSON.parse(payload))
    puts "[consumer] #{queue.name} received #{properties[:type]}, from #{properties[:app_id]}: #{payload}\n"
end

begin
    while true
        sleep(3)
    end
rescue Interrupt
    connection.close
    puts "\nShutting down gracefully."
    exit
end