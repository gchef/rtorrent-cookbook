#####################################################################################
###                                  RTORRENT                                     ###
#####################################################################################
#
default[:rtorrent][:version]               = "0.8.9"
default[:rtorrent][:source]                = "http://libtorrent.rakshasa.no/downloads/rtorrent-#{rtorrent[:version]}.tar.gz"
default[:rtorrent][:checksum]              = "15dc9e8dd45d070f447e599bef08ef0ca421bac6e7f55e608dcd19360594af64"
default[:rtorrent][:libtorrent][:version]  = "0.12.9"
default[:rtorrent][:libtorrent][:source]   = "http://libtorrent.rakshasa.no/downloads/libtorrent-#{rtorrent[:libtorrent][:version]}.tar.gz"
default[:rtorrent][:libtorrent][:checksum] = "cca70eb36a0c176bbd6fdb3afe2bc9f163fa4c9377fc33bc29689dec60cf6d84"

default[:rtorrent][:package_dependencies] = %w[
  autoconf automake autotools-dev binutils cpp cpp-4.1 dpkg-dev g++ g++-4.1 gcc
  gcc-4.1 gcc-4.1-base libapr1 libaprutil1 libc6-dev libcppunit-dev libcurl3
  libcurl4-openssl-dev libexpat1 libidn11 libkrb5-dev libgssrpc4 libmagic1
  libncurses5-dev libneon26 libpcre3 libpq5 libsigc++-2.0-dev libsqlite0
  libsqlite3-0 libssl-dev libstdc++6-4.1-dev libsvn1 libtool libxml2
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
default[:rtorrent][:check_hash]          = "no"
default[:rtorrent][:encryption]          = "allow_incoming,enable_retry,prefer_plaintext"
default[:rtorrent][:ratio]               = true
default[:rtorrent][:ratio_min]           = 1000
default[:rtorrent][:ratio_max]           = 2000
default[:rtorrent][:ratio_upload]        = "200M"

######################################################################## THROTTLE ###
#
default[:rtorrent][:upload_rate]          = 0
default[:rtorrent][:download_rate]        = 0
default[:rtorrent][:min_peers]            = 2
default[:rtorrent][:max_peers]            = 40
default[:rtorrent][:min_peers_seed]       = 2
default[:rtorrent][:max_peers_seed]       = 80
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
default[:rtorrent][:hash_read_ahead]     = 10
default[:rtorrent][:hash_interval]       = 100
default[:rtorrent][:hash_max_tries]      = 2
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

default[:rutorrent][:version]            = "3.3"
default[:rutorrent][:source]             = "http://rutorrent.googlecode.com/files/rutorrent-#{rutorrent[:version]}.tar.gz"
default[:rutorrent][:checksum]           = "5349b2b32b37896a822cac287dadc9c9d3c2322d00cb5dd60cf8fdd033b62557"

default[:rutorrent][:plugins][:source]   = "http://rutorrent.googlecode.com/files/plugins-#{rutorrent[:version]}.tar.gz"
default[:rutorrent][:plugins][:checksum] = "360cf2328c4b135a7c09871fd220bf17e78f2e3bcb2d51135b1acce6c7238250"
