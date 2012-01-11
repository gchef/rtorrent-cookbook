include_recipe "rtorrent::dependencies"
include_recipe "rtorrent::libtorrent"
include_recipe "rtorrent::rtorrent"

template "/etc/init.d/rtorrent" do
  source "rtorrent.init.erb"
  mode "0755"
  backup false
end
