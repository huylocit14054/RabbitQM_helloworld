#!/usr/bin/env ruby
require "rubygems"
require 'bunny'

connection = Bunny.new(host:"52.14.65.170",user: "admin", password: "admin")
connection.start

channel = connection.create_channel
queue = channel.queue('hello')

begin
    puts ' [*] Waiting for messages. To exit press CTRL+C'
    queue.subscribe(block: true) do |_delivery_info, _properties, body|
      puts " [x] Received #{body}"
    end
  rescue Interrupt => _
    connection.close
  
    exit(0)
  end