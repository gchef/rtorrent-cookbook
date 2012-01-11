package "python-scgi"

remote_file "/usr/local/src/rutorrent-#{node[:rutorrent][:version]}.tar.gz" do
  source node[:rutorrent][:source]
  checksum node[:rutorrent][:checksum]
  backup false
  action :create_if_missing
end

remote_file "/usr/local/src/plugins-#{node[:rutorrent][:version]}.tar.gz" do
  source node[:rutorrent][:plugins][:source]
  checksum node[:rutorrent][:plugins][:checksum]
  backup false
  action :create_if_missing
end

apt_repository "mediainfo" do
  uri "http://ppa.launchpad.net/shiki/mediainfo/ubuntu"
  keyserver "keyserver.ubuntu.com"
  key "F9D8BC54"
  action :add
end

package "mediainfo"

directory "/var/log/rutorrent" do
  owner "www-data"
  group "www-data"
  mode "0755"
  recursive true
end
