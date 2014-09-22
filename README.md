# AUTHOR
------
L A JACKSON (leej+sunra@sowhatresearch.com)

COPYRIGHT
---------
So What Research Ltd 2013

DESCRIPTION
-----------
ffs-relay is a layer over ffserver, piping it with the feed from ffmpeg,
monitoring the process and restarting as neccessary. ffserver-relay is
responsible for starting ffserver and the capture program used to feed ffserver
from the capture card.

Edit /etc/sunra/config.yml specifying the capture command and if
the output cannot be natively captured by ffmpeg, specify ffmpeg_pipe with:

ffmpeg_pipe: ffmpeg -v 0 -i - http://localhost:8090/feed1.ffm"

This allows for the capture and relaying of capture via 3rd party code e.g.
bmdcapture.

Ensure that you have a working ffserver installation - it is advised that a 
version be built from source where possible. An example ffserver.conf file
is included in the config directory.

REQUIREMENTS
-------------
ffserver
ffmpeg
ruby > 2.0.0

INSTALL
------------
    cd ffserver-relay
    bundle install

    rvmsudo rake install

-- or --

    sudo rake install

CONFIGURATION
-------------
configration of sunra-ffserver-relay is done via editing /etc/sunra/relay.yml

There are two scenarios supported for capture - one where a seperate program
captures output from the video capture card and this is piped directly through
ffmpeg, the other where ffmpeg captures the audio and video directly. Please
see the config file for examples.

USAGE
----------
To start/stop etc

    /etc/init.d/sunra-ffserver-relay start
    /etc/init.d/sunra-ffserver-relay stop

obtain the status:

    /etc/init.d/sunra-ffserver-relay status

start the relay in the foreground:

    /etc/init.d/sunra-ffserver-relay monitor


