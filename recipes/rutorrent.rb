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

include_recipe "rtorrent"
include_recipe "apache2"
include_recipe "apache2::mod_php5"

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

bash "enable Apache modules" do
  code <<-EOH
  a2enmod scgi
  a2enmod auth_digest
  a2enmod ssl
  EOH
  notifies :reload, resources(:service => "apache2"), :immediately
end

template "/etc/apache2/sites-available/rutorrent-ssl" do
  source "rutorrent-ssl.erb"
  mode 0644
  backup false
end

bash "enable Apache rutorrent-ssl" do
  cwd "/etc/apache2"
  code <<-EOH
  a2dissite default
  a2dissite default-ssl
  a2ensite rutorrent-ssl
  EOH
  notifies :reload, resources(:service => "apache2"), :immediately
end

bash "set up latest rutorrent" do
  cwd "/var/www"
  code <<-EOH
  svn co http://rutorrent.googlecode.com/svn/trunk/rutorrent
  EOH
  not_if "test -d /var/www/rutorrent/.svn"
end

bash "set up all rutorrent plugins" do
  cwd "/var/www/rutorrent/"
  code <<-EOH
  wget http://rutorrent.googlecode.com/files/plugins-3.1.tar.gz
  tar xzf plugins-3.1.tar.gz
  rm -f plugins-3.1.tar.gz
  EOH
 not_if "test -d /var/www/rutorrent/plugins"
end

bash "set up rutorrent rpc plugin" do
  cwd "/tmp"
  code <<-EOH
  svn co http://rutorrent.googlecode.com/svn/trunk/plugins/rpc
  mv rpc /var/www/rutorrent/plugins/
  EOH
  not_if "test -d /var/www/rutorrent/plugins/rpc"
end

bash "replace rutorrent darkpal theme with oblivion" do
  cwd "/var/www/rutorrent/plugins"
  code <<-EOH
  rm -fR darkpal
  wget http://cl.ly/1f778b11b8a9d3b4f2fc/content
  unzip oblivion.zip
  rm -f oblivion.zip
  EOH
  not_if "test -d /var/www/rutorrent/plugins/oblivion"
end

directory "/var/log/rutorrent" do
  owner "www-data"
  group "www-data"
  mode 0755
  recursive true
end

data_bag("users").each do |user|
  properties = data_bag_item("users", user)
  name = properties["id"]
  index = properties["index"]

  if File.directory?('/etc/apache2')
    apache2conf = File.read('/etc/apache2/apache2.conf')
    unless apache2conf.include? "127.0.0.1:500#{index}"
      File.open('/etc/apache2/apache2.conf', 'a') { |f| f.puts "SCGIMount /var/www/rutorrent/RPC#{index} 127.0.0.1:500#{index}" }
    end

    file "/etc/apache2/.passwds" do
      mode 0644
      action :create_if_missing
      backup false
    end

    if File.exists?('/etc/apache2/.passwds')
      htdigest = properties["htdigest"]
      apache2passwds = File.read('/etc/apache2/.passwds')
      unless apache2passwds.include? htdigest
        File.open('/etc/apache2/.passwds', 'a') { |f| f.puts "#{name}:Authorized:#{htdigest}" }
      end
    end

    scgi_mounts
  end

  directory "/var/www/rutorrent/conf/users/#{name}" do
    owner "www-data"
    group "www-data"
    mode 0755
  end

  template "/var/www/rutorrent/conf/users/#{name}/access.ini" do
    source "rutorrent.access.ini.erb"
    owner "www-data"
    group "www-data"
    mode 0755
    backup false
  end

  template "/var/www/rutorrent/conf/users/#{name}/plugins.ini" do
    source "rutorrent.plugins.ini.erb"
    owner "www-data"
    group "www-data"
    mode 0755
    backup false
  end

  template "/var/www/rutorrent/conf/users/#{name}/config.php" do
    source "rutorrent.config.php.erb"
    owner "www-data"
    group "www-data"
    mode 0755
    backup false
    variables(
      :name => name,
      :port => "500#{index}",
      :rpc => "RPC#{index}"
    )
  end
end

execute "chmod -fR 755 /var/www/rutorrent && chown -fR www-data:www-data /var/www/rutorrent"
