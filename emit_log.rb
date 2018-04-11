#!/usr/bin/env ruby
require 'bunny'

connection = Bunny.new(host:"52.14.65.170",user: "admin", password: "admin")
connection.start

channel = connection.create_channel
exchange = channel.fanout('logs')

message = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')

exchange.publish(message)
puts " [x] Sent #{message}"

connection.close