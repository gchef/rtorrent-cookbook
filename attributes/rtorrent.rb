default[:rtorrent][:version]              = "0.8.6"
default[:rtorrent][:source]               = "http://libtorrent.rakshasa.no/downloads/rtorrent-#{rtorrent[:version]}.tar.gz"
default[:rtorrent][:checksum]             = "b804c45c01c40312926bcea6b55bb084"
default[:rtorrent][:libtorrent][:version] = "0.12.6"
default[:rtorrent][:libtorrent][:source]  = "http://libtorrent.rakshasa.no/downloads/libtorrent-#{rtorrent[:libtorrent][:version]}.tar.gz"
default[:rtorrent][:libtorrent][:checksum]= "037499ed708aaf72988cee60e5a8d96b"

default[:rtorrent][:min_peers]        = 20
default[:rtorrent][:max_peers]        = 100
default[:rtorrent][:min_peers_seed]   = 10
default[:rtorrent][:max_peers_seed]   = 50
default[:rtorrent][:max_uploads]      = 20
default[:rtorrent][:download_rate]    = 0
default[:rtorrent][:upload_rate]      = 0

default[:rtorrent][:ratio]            = true
default[:rtorrent][:ratio_min]        = 200
default[:rtorrent][:ratio_max]        = 500
default[:rtorrent][:ratio_upload]     = "200M"

default[:rtorrent][:port_random]      = "yes"
default[:rtorrent][:check_hash]       = "no"
default[:rtorrent][:use_udp_trackers] = "no"
default[:rtorrent][:encryption]       = "allow_incoming,enable_retry,prefer_plaintext"

default[:rtorrent][:hash_read_ahead]  = 64
default[:rtorrent][:hash_interval]    = 8
default[:rtorrent][:hash_max_tries]   = 8
default[:rtorrent][:max_open_files]   = 256

default[:rtorrent][:dht]              = "disable"
default[:rtorrent][:peer_exchange]    = "no"
default[:rtorrent][:max_memory_usage] = "256M"



### RUTORRENT
default[:rutorrent][:version]   = "3.1"
default[:rutorrent][:source]    = "http://rutorrent.googlecode.com/files/rutorrent-#{rutorrent[:version]}.tar.gz"
default[:rutorrent][:checksum]   = "ec486585b1e786b54d01c692d50a8b5303c78a6f"
default[:rutorrent][:plugins][:source]    = "http://rutorrent.googlecode.com/files/plugins-#{rutorrent[:version]}.tar.gz"
default[:rutorrent][:checksum]   = "e74461ec0f7fed2444832c0c554d024ad60369ef"
