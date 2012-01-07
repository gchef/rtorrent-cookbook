package "apache2-utils"
package "php5"
package "php5-cgi"
package "php5-cli"
package "php5-common"
package "php5-curl"
package "php5-dev"
package "php5-geoip"
package "php5-sqlite"
package "php5-xmlrpc"
package "libapache2-mod-scgi"

package "python-scgi"

package "ca-certificates" # common CA certificates
package "subversion"
package "ssl-cert"
package "openssl"

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

bash "set up rutorrent v#{node[:rutorrent][:version]}" do
  cwd "/var/www"
  code %{
    if [ $(cat /var/www/rutorrent/js/webui.js | grep -c "version: \"#{node[:rutorrent][:version]}) = 0 ]; then
      tar -zxf /usr/local/src/rutorrent-#{node[:rutorrent][:version]}.tar.gz
      rm -fR rutorrent/plugins
      cd rutorrent
      tar -zxf /usr/local/src/plugins-#{node[:rutorrent][:version]}.tar.gz
    fi
  }
end

apt_repository "mediainfo" do
  uri "http://ppa.launchpad.net/shiki/mediainfo/ubuntu"
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

execute "chmod -fR 777 /var/www/rutorrent/share"
