default[:rtorrent][:version]               = "0.8.6"
default[:rtorrent][:source]                = "http://libtorrent.rakshasa.no/downloads/rtorrent-#{rtorrent[:version]}.tar.gz"
default[:rtorrent][:checksum]              = "b804c45c01c40312926bcea6b55bb084"
default[:rtorrent][:libtorrent][:version]  = "0.12.6"
default[:rtorrent][:libtorrent][:source]   = "http://libtorrent.rakshasa.no/downloads/libtorrent-#{rtorrent[:libtorrent][:version]}.tar.gz"
default[:rtorrent][:libtorrent][:checksum] = "037499ed708aaf72988cee60e5a8d96b"

# http://torrentfreak.com/optimize-your-BitTorrent-download-speed/
default[:rtorrent][:min_peers]        = 40
default[:rtorrent][:max_peers]        = 400
default[:rtorrent][:min_peers_seed]   = 20
default[:rtorrent][:max_peers_seed]   = 200
default[:rtorrent][:max_uploads]      = 40
default[:rtorrent][:download_rate]    = 0
default[:rtorrent][:upload_rate]      = 0

default[:rtorrent][:ratio]            = true
default[:rtorrent][:ratio_min]        = 1000
default[:rtorrent][:ratio_max]        = 2000
default[:rtorrent][:ratio_upload]     = "200M"

default[:rtorrent][:port_random]      = "yes"
default[:rtorrent][:check_hash]       = "no"
default[:rtorrent][:use_udp_trackers] = "no"
default[:rtorrent][:encryption]       = "allow_incoming,enable_retry,prefer_plaintext"

default[:rtorrent][:hash_read_ahead]  = 10
default[:rtorrent][:hash_interval]    = 10
default[:rtorrent][:hash_max_tries]   = 5
default[:rtorrent][:max_open_files]   = 768

default[:rtorrent][:dht]                 = "disable"
default[:rtorrent][:peer_exchange]       = "no"
default[:rtorrent][:max_memory_usage]    = "1024M"
default[:rtorrent][:send_buffer_size]    = 16384
default[:rtorrent][:receive_buffer_size] = 16384



### RUTORRENT
default[:rutorrent][:version]            = "3.2"
default[:rutorrent][:source]             = "http://rutorrent.googlecode.com/files/rutorrent-#{rutorrent[:version]}.tar.gz"
default[:rutorrent][:checksum]           = "516c1c5c7360f540812eb38bacaa60b2"

default[:rutorrent][:plugins][:source]   = "http://rutorrent.googlecode.com/files/plugins-#{rutorrent[:version]}.tar.gz"
default[:rutorrent][:plugins][:checksum] = "660ec019878b98c7c77b0aa6a232480a"

#default[:rutorrent][:logoff][:version]   = "1.3"
#default[:rutorrent][:logoff][:source]    = "http://rutorrent-logoff.googlecode.com/files/logoff-#{rutorrent[:logoff][:version]}.tar.gz"
#default[:rutorrent][:logoff][:checksum]  = "53920db02625ecbb3a00dbc60b24336d6b63f54a"
