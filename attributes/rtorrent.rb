#####################################################################
### RTORRENT
default[:rtorrent][:version]               = "0.8.6"
default[:rtorrent][:source]                = "http://libtorrent.rakshasa.no/downloads/rtorrent-#{rtorrent[:version]}.tar.gz"
default[:rtorrent][:checksum]              = "b804c45c01c40312926bcea6b55bb084"
default[:rtorrent][:libtorrent][:version]  = "0.12.6"
default[:rtorrent][:libtorrent][:source]   = "http://libtorrent.rakshasa.no/downloads/libtorrent-#{rtorrent[:libtorrent][:version]}.tar.gz"
default[:rtorrent][:libtorrent][:checksum] = "037499ed708aaf72988cee60e5a8d96b"

### GENERAL SETTINGS
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

### THROTTLE SETTINGS
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

### TRACKER RELATED SETTINGS
#
default[:rtorrent][:port_random]      = "yes"
default[:rtorrent][:peer_exchange]    = "no"
default[:rtorrent][:use_udp_trackers] = "yes"
default[:rtorrent][:dht]              = "disable"
default[:rtorrent][:tracker_numwant]  = "-1"

### ADVANCED SETTINGS
#
# http://posidev.com/blog/2009/06/04/set-ulimit-parameters-on-ubuntu/
# http://www.cyberciti.biz/faq/linux-unix-nginx-too-many-open-files/
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



#####################################################################
### RUTORRENT

default[:rutorrent][:version]            = "3.2"
default[:rutorrent][:source]             = "http://rutorrent.googlecode.com/files/rutorrent-#{rutorrent[:version]}.tar.gz"
default[:rutorrent][:checksum]           = "516c1c5c7360f540812eb38bacaa60b2"

default[:rutorrent][:plugins][:source]   = "http://rutorrent.googlecode.com/files/plugins-#{rutorrent[:version]}.tar.gz"
default[:rutorrent][:plugins][:checksum] = "660ec019878b98c7c77b0aa6a232480a"
