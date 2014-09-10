var search_data = {"index":{"searchIndex":["object","sunra","ffserver","relay","_check_feed_cache_file()","_start_feed()","_start_ffserver()","capture_pid()","ffserver_pid()","new()","start()","status()","stop()","gemfile","gemfile.lock","guardfile","readme","rakefile","sunra-ffserver-relay","ffserver.conf.example"],"longSearchIndex":["object","sunra","sunra::ffserver","sunra::ffserver::relay","sunra::ffserver::relay#_check_feed_cache_file()","sunra::ffserver::relay#_start_feed()","sunra::ffserver::relay#_start_ffserver()","sunra::ffserver::relay#capture_pid()","sunra::ffserver::relay#ffserver_pid()","sunra::ffserver::relay::new()","sunra::ffserver::relay#start()","sunra::ffserver::relay#status()","sunra::ffserver::relay#stop()","","","","","","",""],"info":[["Object","","Object.html","",""],["Sunra","","Sunra.html","",""],["Sunra::FFServer","","Sunra/FFServer.html","",""],["Sunra::FFServer::Relay","","Sunra/FFServer/Relay.html","","<p>Description\n<p>Starts ffserver (if it isnt running) and then runs whatever command is\nrequired to capture …\n"],["_check_feed_cache_file","Sunra::FFServer::Relay","Sunra/FFServer/Relay.html#method-i-_check_feed_cache_file","(feed_cache_file)","<p>Description\n<p>if the feed file in ffserver exists and we dont have permissions to\noverwrite it, we&#39;ll …\n"],["_start_feed","Sunra::FFServer::Relay","Sunra/FFServer/Relay.html#method-i-_start_feed","()","<p>Description\n<p>Start feed via configured command - if it crashes for any reason attempt to\nrestart via recursive …\n"],["_start_ffserver","Sunra::FFServer::Relay","Sunra/FFServer/Relay.html#method-i-_start_ffserver","()","<p>Description\n<p>Start ffserver - if it crashes for any reason attempt to restart via\nrecursive call to _start_ffserver. …\n"],["capture_pid","Sunra::FFServer::Relay","Sunra/FFServer/Relay.html#method-i-capture_pid","()","<p>Description\n<p>Return the pid of the capture process\n"],["ffserver_pid","Sunra::FFServer::Relay","Sunra/FFServer/Relay.html#method-i-ffserver_pid","()","<p>Description\n<p>Return the pid of the ffserver\n"],["new","Sunra::FFServer::Relay","Sunra/FFServer/Relay.html#method-c-new","()","<p>loads the config file.\n"],["start","Sunra::FFServer::Relay","Sunra/FFServer/Relay.html#method-i-start","(monitor=false, daemonized=true)","<p>Description\n<p>Start ffserver and the capture process if neither of them are running.\n<p>Params\n"],["status","Sunra::FFServer::Relay","Sunra/FFServer/Relay.html#method-i-status","()","<p>Descripiton\n<p>Return the status of the ffserver and capture processes by checking for the\nexistance of a …\n"],["stop","Sunra::FFServer::Relay","Sunra/FFServer/Relay.html#method-i-stop","()","<p>Description\n<p>Stop both ffserver and capture. Just killing ffserver isn&#39;t always\nsufficient to stop …\n"],["Gemfile","","Gemfile.html","","<p>source &#39;rubygems.org&#39;\n<p>gem “sunra_config”, “~&gt; 0.0.9” gem “sunra_service”, …\n"],["Gemfile.lock","","Gemfile_lock.html","","<p>GEM\n\n<pre>remote: https://rubygems.org/\nspecs:\n  celluloid (0.15.2)\n    timers (~&gt; 1.1.0)\n  celluloid-io (0.15.0) ...</pre>\n"],["Guardfile","","Guardfile.html","","<p># A sample Guardfile # More info at github.com/guard/guard#readme\n<p>guard :rspec do\n\n<pre>watch(%r{^spec/.+_spec\\.rb$}) ...</pre>\n"],["README","","README.html","","<p>AUTHOR\n<p>L A JACKSON (leej+sunra@sowhatresearch.com)\n<p>COPYRIGHT\n"],["Rakefile","","Rakefile.html","","<p>require &#39;rake&#39;\n<p>require &#39;rspec/core/rake_task&#39;\n<p>$ffrelay_paths = { }\n"],["sunra-ffserver-relay","","bin/sunra-ffserver-relay.html","","<p>#!/usr/bin/env bash\n<p>#RUBY=`which ruby` #RUBY=“/home/sowhat/.rvm/environments/ruby-2.0.0-p195” …\n"],["ffserver.conf.example","","config/ffserver_conf_example.html","","<p>Port 8090 BindAddress 0.0.0.0 MaxHTTPConnections 2000 MaxClients 1000\nMaxBandwidth 20000 CustomLog - …\n"]]}}