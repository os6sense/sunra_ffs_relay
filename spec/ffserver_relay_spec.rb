#File:: ffserver_relay_spec.rb

require_relative '../ffserver-relay'
require 'sunra_ps'

include SunraPS

describe Sunra::FFServer::Relay do
  before(:each) { @ffsr = Sunra::FFServer::Relay.new }
  after(:each) { @ffsr.stop }

  describe :start do
    before(:each) do 
      @ffsr.start false, false
    end

    it "creates a lockfile" do
      expect(File).to exist(@ffsr.config.lock_file)
    end

    it "provides a valid pid for ffserver" do
      ff_pid = @ffsr.ffserver_pid
      Integer(ff_pid).should be > 0
      pid_exists?(ff_pid).should eq true
    end

    it "provides a valid pid for ffmpeg" do
      ffmpeg_pid = @ffsr.capture_pid
      Integer(@ffsr.capture_pid).should be > 0
      pid_exists?(ffmpeg_pid).should eq true
    end

    context "if ffserver dies" do
      before(:each) do
        @ff_pid = @ffsr.ffserver_pid
        @capture_pid = @ffsr.capture_pid
        kill "ffserver" # test a sudden restart of ffserver
        pid_exists?(@ff_pid).should eq false
      end

      # This is a complex test since I am testing the actual implementation
      # but since it is essential that restarts actually work it is essential.
      it "ffserver is restarted" do
        puts "Sleeping for 10 seconds to ensure lock file update.."
        sleep 10 # sleep required to allow for restart

        ff_pid_restarted = @ffsr.lock_file.ffserver_pid
        @ff_pid.should_not eq ff_pid_restarted
        pid_exists?(ff_pid_restarted).should eq true

        # Due to ffserver being restarted, ffmpeg will also have been restarted.
        @capture_pid.should_not eq @ffsr.lock_file.capture_pid
      end
    end

    context "if capture/feed dies" do
      before(:each) do
        @ff_pid = @ffsr.ffserver_pid
        @capture_pid = @ffsr.capture_pid
        kill "ffmpeg" # test a sudden restart of ffserver
        pid_exists?(@capture_pid).should eq false
      end

      it "restarts the capture mechanism/feed" do
        puts "Sleeping for 10 seconds to ensure lock file update.."
        sleep 10 # sleep required to allow for restart

        capture_pid_restarted = @ffsr.capture_pid
        @capture_pid.should_not eq capture_pid_restarted
        @ff_pid.should eq @ffsr.ffserver_pid
        pid_exists?(capture_pid_restarted).should eq true
      end
    end
  end

  describe :stop do
    it "kills the processes in the lockfile" do
      @ffsr.start false, false
      ff_pid = @ffsr.ffserver_pid
      ffmpeg_pid = @ffsr.capture_pid

      @ffsr.stop

      pid_exists?(ff_pid).should eq false
      pid_exists?(ffmpeg_pid).should eq false
    end

    it "deletes the lockfile" do
      @ffsr.start false , false
      File.exists?(@ffsr.config.lock_file).should eq true

      @ffsr.stop
      File.exists?(@ffsr.config.lock_file).should eq false
    end

    it "deletes the feed cache file" do
      @ffsr.start false , false
      File.exists?( @ffsr.config.cache_file).should eq true
      @ffsr.stop
      File.exists?( @ffsr.config.cache_file).should eq false
    end
  end

  #describe :status do
    #it "" do
      #pending
    #end
    ## displays whether the processes identifieed 
    ## by the pids in the lockfile are running
  #end
end
