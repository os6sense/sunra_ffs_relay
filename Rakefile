require 'rake'

require 'rspec/core/rake_task'

$ffrelay_paths = { }

INST_TARGET = "/opt/sunra/sunra-ffserver-relay"
INST_TARGET_LIB = "/opt/sunra/lib"
INIT_DIR = "/etc/init.d/"

task :test => :spec
desc "Run specs"
  RSpec::Core::RakeTask.new do |task|
      task.pattern = "./tests/*_spec.rb"
  end

task :default => ['check_requirements'] do
	$ffrelay_paths.each { |k,v| puts k + "..." + v }
  puts "Please run 'sudo rake install' or 'rvmsudo rake install' in order to copy files to their required directories"
end

def check_prog progname
	loc = `which #{progname}`
	fail ("REQUIREMENTS ERROR-#{progname} not found: Please install.") if "" == loc
	$ffrelay_paths[progname] = loc
end

desc "Check for presence of requirements to build and run"
task :check_requirements do
	check_prog "ffmpeg"
	check_prog "ffserver"
end

# INSTALL
task :install => ["sunra-ffserver-relay.rb-file",
                  "ps.rb",
                  "config.rb",
                  "lockfile.rb",
                  "ffserver-relay.rb-file",
                  "logging.rb",
                  "sunra-ffserver-relay",
                  "ffserver_relay_config.yml",
                  ] do
  puts "Installation complete"
end

directory INST_TARGET
file "sunra-ffserver-relay.rb-file" do |t|
  cp "sunra-ffserver-relay.rb", "#{INST_TARGET}/sunra-ffserver-relay.rb", :verbose => true
end

#
directory INST_TARGET
file "ffserver-relay.rb-file" do |t|
  cp "ffserver-relay.rb", "#{INST_TARGET}/ffserver-relay.rb", :verbose => true
end

# LIBS
directory INST_TARGET_LIB
file "ps.rb" do |t|
  cp "../lib/ps.rb", "#{INST_TARGET_LIB}/ps.rb", :verbose => true
end

directory INST_TARGET_LIB
file "config.rb" do |t|
  cp "../lib/config.rb", "#{INST_TARGET_LIB}/config.rb", :verbose => true
end

directory INST_TARGET_LIB
file "lockfile.rb" do |t|
  cp "../lib/lockfile.rb", "#{INST_TARGET_LIB}/lockfile.rb", :verbose => true
end

directory INST_TARGET_LIB
file "logging.rb" do |t|
  cp "../lib/logging.rb", "#{INST_TARGET_LIB}/logging.rb", :verbose => true
end

# CONFIG
directory "#{INST_TARGET}/config"
file "ffserver_relay_config.yml" do |t|
  cp "config/ffserver_relay_config.yml", "#{INST_TARGET}/config/ffserver_relay_config.yml", :verbose => true
end

# Init Wrapper
file "sunra-ffserver-relay" do |t|
  cp "bin/sunra-ffserver-relay", "/etc/init.d/sunra-ffserver-relay", :verbose => true
end
