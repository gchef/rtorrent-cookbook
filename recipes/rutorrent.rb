#
# Cookbook Name:: rtorrent
# Recipe:: rutorrent
#
# Copyright 2010, Gerhard Lazu
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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

bash "set up rutorrent v#{node[:rutorrent][:version]}" do
  cwd "/var/www"
  code <<-EOH
  tar -zxf /usr/local/src/rutorrent-#{node[:rutorrent][:version]}.tar.gz
  rm -fR rutorrent/plugins
  EOH
  not_if %{grep 'version: "#{node[:rutorrent][:version]}"' /var/www/rutorrent/js/webui.js}
end

remote_file "/usr/local/src/plugins-#{node[:rutorrent][:version]}.tar.gz" do
  source node[:rutorrent][:plugins][:source]
  checksum node[:rutorrent][:plugins][:checksum]
  backup false
  action :create_if_missing
end

bash "set up all rutorrent plugins" do
  cwd "/var/www/rutorrent"
  code <<-EOH
  tar -zxf /usr/local/src/plugins-#{node[:rutorrent][:version]}.tar.gz
  EOH
  not_if "test -d /var/www/rutorrent/plugins/rpc"
end

#remote_file "/usr/local/src/logoff-#{node[:rutorrent][:logoff][:version]}.tar.gz" do
  #source node[:rutorrent][:logoff][:source]
  #checksum node[:rutorrent][:logoff][:checksum]
  #backup false
  #action :create_if_missing
#end

#bash "set up logoff plugin" do
  #cwd "/var/www/rutorrent/plugins"
  #code <<-EOH
  #tar -zxf /usr/local/src/logoff-#{node[:rutorrent][:logoff][:version]}.tar.gz
  #EOH
  #not_if "test -d /var/www/rutorrent/plugins/logoff"
#end

directory "/var/log/rutorrent" do
  owner "www-data"
  group "www-data"
  mode "0755"
  recursive true
end

execute "chmod -fR 777 /var/www/rutorrent/share"
