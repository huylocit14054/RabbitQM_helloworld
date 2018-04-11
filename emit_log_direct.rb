#!/usr/bin/env ruby
require 'bunny'

connection = Bunny.new(host:"52.14.65.170",user: "admin", password: "admin")
connection.start

channel = connection.create_channel
exchange = channel.direct('direct_logs')
severity = ARGV.shift || 'info'
message = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')

exchange.publish(message, routing_key: severity)
puts " [x] Sent '#{message}'"

connection.close