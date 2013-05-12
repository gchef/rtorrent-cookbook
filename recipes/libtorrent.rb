remote_file "/usr/local/src/libtorrent-#{node[:rtorrent][:libtorrent][:version]}.tar.gz" do
  source node[:rtorrent][:libtorrent][:source]
  backup false
  action :create_if_missing
end

bash "compiling libtorrent #{node[:rtorrent][:libtorrent][:version]}" do
  cwd "/usr/local/src"
  code %{
    if [ ! -d libtorrent-#{node[:rtorrent][:libtorrent][:version]} ]; then
      tar -zxf libtorrent-#{node[:rtorrent][:libtorrent][:version]}.tar.gz
      cd libtorrent-#{node[:rtorrent][:libtorrent][:version]}
      rm -f scripts/{libtool,lt*}.m4
      ./autogen.sh
      ./configure
      make && make install
    fi
  }
end
