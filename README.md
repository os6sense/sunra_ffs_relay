AUTHOR
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

LICENSE
----------
Sunra
Copyright (C) 2013 So What Research Ltd

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 3
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.