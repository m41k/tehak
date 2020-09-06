#!/usr/bin/env ruby
require 'webrick'

unless ARGV[0]
  STDERR.puts "usage: cgiup [PATH TO CGI SCRIPT]"
  exit 1
end

cgi_script = File.expand_path(ARGV[0])

unless File.exists?(cgi_script)
  STDERR.puts "CGI Script: #{cgi_script} Not Found"
  exit 1
end

server = WEBrick::HTTPServer.new(:Port => 80)
server.mount('/', WEBrick::HTTPServlet::CGIHandler, File.expand_path(ARGV[0]))

trap("INT"){ server.shutdown }
server.start
