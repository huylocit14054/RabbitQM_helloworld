#!/usr/bin/env ruby
require 'bunny'

#connect to RabbitMQ server
connection = Bunny.new(host:"52.14.65.170",user: "admin", password: "admin")
connection.start

#create a channel, which is where most of the API for getting things done resides
channel = connection.create_channel

#To send, we must declare a queue for us to send to
queue = channel.queue('hello')
#then we can publish a message to the queue
channel.default_exchange.publish('Hello World!', routing_key: queue.name)
puts " [x] Sent 'Hello World!'"

#close the connection
connection.close