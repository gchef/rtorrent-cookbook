#####################################################################################
###                                  RTORRENT                                     ###
#####################################################################################
#
default[:rtorrent][:version]               = "0.9.3"
default[:rtorrent][:source]                = "http://libtorrent.rakshasa.no/downloads/rtorrent-#{rtorrent[:version]}.tar.gz"
default[:rtorrent][:libtorrent][:version]  = "0.13.3"
default[:rtorrent][:libtorrent][:source]   = "http://libtorrent.rakshasa.no/downloads/libtorrent-#{rtorrent[:libtorrent][:version]}.tar.gz"

default[:rtorrent][:package_dependencies] = %w[
  autoconf automake autotools-dev binutils cpp dpkg-dev g++ gcc
  gcc-4.7-base libapr1 libaprutil1 libc6-dev libcppunit-dev libcurl3
  libcurl4-openssl-dev libexpat1 libidn11 libkrb5-dev libgssrpc4 libmagic1
  libncurses5-dev libneon27 libpcre3 libpq5 libsigc++-2.0-dev libsqlite0
  libsqlite3-0 libssl-dev libstdc++6-4.6-dev libsvn1 libtool libxml2
  linux-libc-dev m4 make mime-support pkg-config zlib1g-dev libwww-perl
  libwww-curl-perl perl perl-modules comerr-dev sqlite subversion ucf
]

######################################################################### GENERAL ###
#
# http://libtorrent.rakshasa.no/rtorrent/rtorrent.1.html
# http://www.torrent-invites.com/resolved-issues/31375-storage-error-file-chunk-write-error-cannot-allocate-memory.html
# http://forum.fastsh.it/viewtopic.php?f=7&t=323
# http://torrentfreak.com/optimize-your-BitTorrent-download-speed/ ???
# Wonslung's config => http://forums.rutorrent.org/index.php?topic=254.msg1616#msg1616
default[:rtorrent][:check_hash]   = "no"
default[:rtorrent][:encryption]   = "allow_incoming,enable_retry,prefer_plaintext"
default[:rtorrent][:index]        = "00"
default[:rtorrent][:ipaddress]    = node[:ipaddress]
default[:rtorrent][:ratio]        = true
default[:rtorrent][:ratio_max]    = 2000
default[:rtorrent][:ratio_min]    = 1000
default[:rtorrent][:ratio_upload] = "200M"
default[:rtorrent][:rutorrent]    = false

######################################################################## THROTTLE ###
#
default[:rtorrent][:upload_rate]            = 0
default[:rtorrent][:download_rate]          = 0
default[:rtorrent][:min_peers]              = 2
default[:rtorrent][:max_peers]              = 40
default[:rtorrent][:min_peers_seed]         = 2
default[:rtorrent][:max_peers_seed]         = 80
# default[:rtorrent][:max_uploads]          = 50
# default[:rtorrent][:max_uploads_global]   = 0
# default[:rtorrent][:max_downloads_global] = 0

######################################################################### TRACKER ###
#
default[:rtorrent][:port_random]      = "yes"
default[:rtorrent][:peer_exchange]    = "no"
default[:rtorrent][:use_udp_trackers] = "yes"
default[:rtorrent][:dht]              = "disable"
default[:rtorrent][:tracker_numwant]  = "-1"

######################################################################## ADVANCED ###
#
# http://posidev.com/blog/2009/06/04/set-ulimit-parameters-on-ubuntu/
# http://www.cyberciti.biz/faq/linuxtunix-nginx-too-many-open-files/
# http://www.karakas-online.de/forum/viewtopic.php?t=9834
default[:rtorrent][:max_open_files]      = 768
# default[:rtorrent][:max_memory_usage]    = "1024000K"
# default[:rtorrent][:send_buffer_size]    = "1024K"
# default[:rtorrent][:send_buffer_size]    = 0
# default[:rtorrent][:receive_buffer_size] = "128K"
# default[:rtorrent][:receive_buffer_size] = 0


#####################################################################################
###                                  RUTORRENT                                    ###
#####################################################################################
#

default[:rutorrent][:version]            = "3.5"
default[:rutorrent][:source]             = "http://rutorrent.googlecode.com/files/rutorrent-#{rutorrent[:version]}.tar.gz"

default[:rutorrent][:plugins][:source]   = "http://rutorrent.googlecode.com/files/plugins-#{rutorrent[:version]}.tar.gz"
