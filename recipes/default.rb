#
# Cookbook Name:: rtorrent
# Recipe:: default
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

package "autoconf"
package "automake"
package "autotools-dev"
package "binutils"
package "cpp"
package "cpp-4.1"
package "dpkg-dev"
package "g++"
package "g++-4.1"
package "gcc"
package "gcc-4.1"
package "gcc-4.1-base"
package "libapr1"
package "libaprutil1"
package "libc6-dev"
package "libcppunit-dev"
package "libcurl3"
package "libcurl4-openssl-dev"
package "libexpat1"
package "libidn11"
package "libkrb5-dev"
package "libgssrpc4"
package "libmagic1"
package "libncurses5-dev"
package "libneon26"
package "libpcre3"
package "libpq5"
package "libsigc++-2.0-dev"
package "libsqlite0"
package "libsqlite3-0"
package "libssl-dev"
package "libstdc++6-4.1-dev"
package "libsvn1"
package "libtool"
package "libxml2"
package "linux-libc-dev"
package "m4" # a macro processing language
package "make"
package "mime-support"
package "pkg-config" # manage compile and link flags for libraries
package "zlib1g-dev"

package "libwww-perl"
package "libwww-curl-perl"
package "perl"
package "perl-modules"

package "comerr-dev" # common error description library - headers and static libraries
package "sqlite"
package "subversion"
package "ucf" # Update Configuration File: preserve user changes to config files

bash "SVN checkout xmlrpc-c" do
  cwd "/usr/local/src"
  code <<-EOH
  svn co https://xmlrpc-c.svn.sourceforge.net/svnroot/xmlrpc-c/advanced xmlrpc-c
  cd xmlrpc-c
  ./configure --disable-cplusplus
  make && make install
  EOH
  not_if "which xmlrpc-c-config"
end

remote_file "/usr/local/src/libtorrent-#{node[:rtorrent][:libtorrent][:version]}.tar.gz" do
  source node[:rtorrent][:libtorrent][:source]
  checksum node[:rtorrent][:libtorrent][:checksum]
  backup false
  action :create_if_missing
end

bash "compiling libtorrent #{node[:rtorrent][:libtorrent][:version]}" do
  cwd "/usr/local/src"
  code <<-EOH
  tar -zxf libtorrent-#{node[:rtorrent][:libtorrent][:version]}.tar.gz
  cd libtorrent-#{node[:rtorrent][:libtorrent][:version]}
  rm -f scripts/{libtool,lt*}.m4
  ./autogen.sh
  ./configure
  make && make install
  EOH
  not_if "test -L /usr/local/lib/libtorrent.so"
end

remote_file "/usr/local/src/rtorrent-#{node[:rtorrent][:version]}.tar.gz" do
  source node[:rtorrent][:source]
  checksum node[:rtorrent][:checksum]
  backup false
  action :create_if_missing
end

bash "compiling rtorrent #{node[:rtorrent][:version]}" do
  cwd "/usr/local/src"
  code <<-EOH
  tar -zxf rtorrent-#{node[:rtorrent][:version]}.tar.gz
  cd rtorrent-#{node[:rtorrent][:version]}
  rm -f scripts/{libtool,lt*}.m4
  ./autogen.sh
  ./configure --with-xmlrpc-c
  make && make install
  ldconfig
  EOH
  not_if "which rtorrent"
end

template "/etc/init.d/rtorrent" do
  source "rtorrent.init.erb"
  mode "0755"
  backup false
end
