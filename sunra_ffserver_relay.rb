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
require_relative 'ffserver_relay'

include Sunra::Utils::Service

usage if ARGV.length != 1

run(Sunra::FFServer::Relay.new, ARGV[0], 'sunra-ffsrelay-server.rb')
