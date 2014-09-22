# File:: ffserver-relay.rb
# ==== Description

require 'sunra_utils/config/relay'
require 'sunra_utils/ps'
require 'sunra_utils/logging'
require 'sunra_utils/lockfile'

module Sunra
  module FFServer
    # ==== Description
    # Starts ffserver (if it isnt running) and then runs whatever
    # command is required to capture from the capture card. The output from
    # this is then piped to ffserver if a ffmpeg pipe is specified. See
    # the config file for an example

    # ==== Description
    # Wraps ffmpeg to provide a stream to ffserver, performing some management
    # of the process such as auto restarting and cache cleaning.
    class Relay
      include Sunra::Utils::Logging
      include Sunra::Utils::PS

      # Return the config file for the relay server.
      attr_reader :config

      # Return the lock_file for the relay server.
      attr_reader :lock_file

      # loads the config file.
      def initialize
        @config = Sunra::Utils::Config::Relay

        @lock_file = Sunra::Utils::FFSRelayLockFile.new(@config.lock_file)
        @feed_cache_file = @config.cache_file
      end

      # ==== Description
      # Return the pid of the capture process
      def capture_pid
        @lock_file.capture_pid
      end

      # ==== Description
      # Return the pid of the ffserver
      def ffserver_pid
        @lock_file.ffserver_pid
      end

      # ==== Description
      # Start ffserver and the capture process if neither of them are running.
      #
      # ==== Params
      # +monitor+:: do not exit the main loop. Default false.
      # +daemonized+:: do not exit the main loop. Default true.
      #
      # ==== Notes
      # The params monitor and daemonized do essentially the same thing, i.e.
      # start a loop and don't exit until the lockfile is deleted. The
      # difference is in the default values and, importantly, the *intent*.
      #
      # monitor will be set to true when called from the command line and
      # we want to be able to restart the feed with 'q'. Otherwise it
      # will be false but in that case, we will be running this as a daemon,
      # and daemonized will be true.
      #
      # ... its subtle (i.e. stupid)
      def start(monitor = false, daemonized = true)
        _check_feed_cache_file @feed_cache_file

        @ffserver_pid, @ffserver_thread = _start_ffserver
        @cmd_pid, @cmd_thread = _start_feed

        @lock_file.create([@ffserver_pid, @cmd_pid])

        logger.info 'Monitoring Relay Service. CTL-C to exit, q to restart '\
            'feed' if monitor

        if monitor || daemonized
          loop do
            sleep 1
            exit 0 unless @lock_file.exists?
          end
        end
      end

      # ==== Description
      # Stop both ffserver and capture. Just killing ffserver isn't always
      # sufficient to stop the feed/capture program as well, however PS.kill
      # also kills all child processes too.
      def stop
        if @lock_file.exists?
          pids = @lock_file.pids     # copy the pids
          @lock_file.delete          # and delete the lock file so that the
                                     # processes dont attempt to restart
          pids.each do |line|
            kill Integer(line)
          end
        end

        File.delete @feed_cache_file if File.exists? @feed_cache_file
      end

      # ==== Descripiton
      # Return the status of the ffserver and capture processes by checking
      # for the existance of a lock file with pids.
      def status
        l = lambda do |pn, pid|
          logger.info "#{pn} [PID: #{pid}] " \
                    "#{pid_exists?(pid) ? 'Running' : 'Invalid!'}"
        end
        if @lock_file.exists?
          l.call('ffserver', @lock_file.ffserver_pid)
          l.call('capture', @lock_file.capture_pid)
        else
          logger.info 'Service Stopped or Lock File Missing!'
          logger.info 'FFServer is Running!' if (
            ffpid = Integer(get_pid('ffserver'))
          ) > -1

          if Integer(cmdpid = get_pid(cmd =
                                   @config.capture_command.split(' ')[0])) > 0
            logger.info "Instance of capture command (#{cmd}) found running..."
          end

          if cmdpid > 0 && ffpid > 0
            logger.warn 'WARNING! Service Status Inconsistent. ' \
            'Manually kill capture process and restart.'
          end
        end
      end

      protected

      # ==== Description
      # if the feed file in ffserver exists and we dont have permissions
      # to overwrite it, we'll end up with a "stale" feed. Check for this
      # and attempt to delete it. If the file cannot be deleted we need to
      # exit with a fatal error.
      def _check_feed_cache_file(feed_cache_file)
        begin
          f_present = File.exists?(feed_cache_file)
          File.open(feed_cache_file, 'w').close # attempt to open the file
                                                # so that we can capture an
                                                # the exception on failure.
          File.delete feed_cache_file if not f_present
        rescue
          logger.fatal "Insufficient permissions to open feed temporary" \
                         "file #{feed_cache_file}"
          exit 1
        end
      end

      # ==== Description
      # Start ffserver - if it crashes for any reason attempt to restart
      # via recursive call to _start_ffserver.
      def _start_ffserver
        return run_background_cmd("ffserver", @config.ffserver_command) do
          if @lock_file.exists?
            logger.error "* FFSERVER DIED!!!!!!!!, attempting to restart"
            sleep 0.1
            @ffserver_pid, @ffserver_thread = _start_ffserver
            @lock_file.ffserver_pid = @ffserver_pid
          end
        end
      end

      # ==== Description
      # Start feed via configured command - if it crashes for any reason
      # attempt to restart via recursive call to _start_feed. Note that there
      # is a delay loop in order to give ffserver a chance to restart in case
      # (the server is slow starting up) is the cause of the feed stopping.
      def _start_feed
        cmd = @config.capture_command
        cmd += " | #{@config.ffmpeg_pipe}" if @config.ffmpeg_pipe != ""

        return run_background_cmd(@config.command_name, cmd) do
          if @lock_file.exists?
            [3, 2, 1].each do |x|
              logger.error "* (FEED) #{@config.command_name} DIED!!!!!!!!." \
                "Attempting to restart in #{x}"
              sleep 1
            end

            @cmd_pid, @cmd_thread = _start_feed
            @lock_file.capture_pid = @cmd_pid
          end
        end
      end
    end
  end
end
