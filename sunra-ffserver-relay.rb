#!/usr/local/bin/ruby

# File:: sunra-ffserver-relay.rb
#
# Description::
# Wraps around Sunra::FFServer::Relay allowing the relay process to
# be started and stopped. NOT a daemon since ffserver and ffmpeg
# are spawned processes. If a file is being relayed it will loop
# since this will be detected as the feed dying and the relay server
# will restart the feed from the begining.

require 'sunra_utils/service'
require_relative 'ffserver-relay'

include Sunra::Utils::Service

service_name = 'sunra-ffsrelay-server.rb'
usage if ARGV.length != 1
ffsr = Sunra::FFServer::Relay.new
run(ffsr, ARGV[0], service_name)
