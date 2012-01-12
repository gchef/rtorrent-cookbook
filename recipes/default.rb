include_recipe "rtorrent::dependencies"
include_recipe "rtorrent::libtorrent"
include_recipe "rtorrent::rtorrent"

# template "/etc/init.d/rtorrent" do
#   source "rtorrent.init.erb"
#   mode "0755"
#   backup false
# end

# Cleanup - will use upstart
file "/etc/init.d/rtorrent" do
  action :delete
end

service "rtorrent" do
  provider Chef::Provider::Service::Upstart
end

template "/etc/init/rtorrent.conf" do
  cookbook "rtorrent"
  source "rtorrent.upstart.erb"
  mode 0644
  backup false
end

service "rtorrent" do
  action [:enable, :start]
end
