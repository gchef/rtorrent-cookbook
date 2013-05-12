remote_file "/usr/local/src/rtorrent-#{node[:rtorrent][:version]}.tar.gz" do
  source node[:rtorrent][:source]
  backup false
  action :create_if_missing
end

bash "compiling rtorrent #{node[:rtorrent][:version]}" do
  cwd "/usr/local/src"
  code %{
    if [ ! -d rtorrent-#{node[:rtorrent][:version]} ]; then
      tar -zxf rtorrent-#{node[:rtorrent][:version]}.tar.gz
      cd rtorrent-#{node[:rtorrent][:version]}
      rm -f scripts/{libtool,lt*}.m4
      ./autogen.sh
      ./configure --with-xmlrpc-c
      make && make install
      ldconfig
    fi
  }
end
