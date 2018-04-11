#!/usr/bin/env ruby
require 'bunny'

#connect to RabbitMQ server
connection = Bunny.new(host:"52.14.65.170",user: "admin", password: "admin")
connection.start

#create a channel, which is where most of the API for getting things done resides
channel = connection.create_channel

queue = channel.queue('task_queue', durable: true)

message = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')

queue.publish(message, persistent: true)
puts " [x] Sent #{message}"

#close the connection
connection.close