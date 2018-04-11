#!/usr/bin/env ruby
require "rubygems"
require 'bunny'

connection = Bunny.new(host:"52.14.65.170",user: "admin", password: "admin")
connection.start

channel = connection.create_channel
queue = channel.queue('task_queue', durable: true)
puts ' [*] Waiting for messages. To exit press CTRL+C'
    
begin
    queue.subscribe(manual_ack: true ,block: true) do |delivery_info, _properties, body|
        puts " [x] Received #{body}"
        # imitate some work
        sleep body.count('.').to_i
        puts ' [x] Done'
        channel.ack(delivery_info.delivery_tag)
      end
  rescue Interrupt => _
      connection.close
end