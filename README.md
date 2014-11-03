# AUTHOR
------
L A JACKSON (leej+sunra@sowhatresearch.com)

COPYRIGHT
---------
So What Research Ltd 2014

LICENSE
-------
This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 3 of the License, or (at your option) any later
version.

DESCRIPTION
-----------
ffs_relay is responsible for starting ffserver and the capture program used to
feed ffserver from the capture card. It is a layer over ffserver, piping it
with the feed from ffmpeg, monitoring the process and restarting both feed and
server as neccessary to ensure stability/continuity. 

It acts as the first part in the chain for a suite of programs for the live
recording/distribution of audio/video in multiple formats.

REQUIREMENTS
-------------
ffmpeg
ruby > 2.0.0

It is advised that a version ffmpeg be built from source if possible to ensure
that it is not crippled (e.g. lacking mp3 encoding support). 

Also ensure that you have a working ffserver installation. An example
ffserver.conf file is included in the config directory.

INSTALL
------------
    cd ffserver-relay
    bundle install

    rvmsudo rake install

-- or --

    sudo rake install

CONFIGURATION
-------------
configration of sunra_ffserver_relay is done via editing /etc/sunra/relay.yml

There are two scenarios supported for capture - one where a seperate program
captures output from the video capture card and this is piped directly through
ffmpeg, the other where ffmpeg captures the audio and video directly. Please
see the example config file for examples.

USAGE
----------
To start/stop etc

    /etc/init.d/sunra-ffserver-relay start
    /etc/init.d/sunra-ffserver-relay stop

obtain the status:

    /etc/init.d/sunra-ffserver-relay status

start the relay in the foreground:

    /etc/init.d/sunra-ffserver-relay monitor


