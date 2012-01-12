action :create do
  # Essential folders for rtorrent
  #
  %w[.session watch torrents].each do |dir|
    directory "#{@@user.home}/#{dir}" do
      owner @@user.name
      group @@user.name
      mode "0777"
    end
  end

  # Service definition so that changes in the upstart template can trigger a
  # restart
  #
  # service "rtorrent-#{@@user.name}" do
  #   provider Chef::Provider::Service::Upstart
  #   action :enable
  # end

  # rtorrent upstart job, specific for this user
  #
  template "/etc/init/rtorrent-#{@@user.name}.conf" do
    cookbook "rtorrent"
    source "rtorrent.user.upstart.erb"
    mode 0644
    variables(
      :user => @@user
    )
    backup false
    # notifies :restart, resources(:service => "rtorrent-#{@@user.name}"), :delayed
  end

  # rtorrent config, specific for this user
  #
  template "#{@@user.home}/.rtorrent.rc" do
    cookbook "rtorrent"
    source "rtorrent.rc.erb"
    mode "0644"
    owner "root"
    group "root"
    variables(
      :user => @@user
    )
    backup false
    # notifies :restart, resources(:service => "rtorrent-#{@@user.name}"), :delayed
  end

  # Ensure user's rtorrent is running
  #
  # service "rtorrent-#{@@user.name}" do
  #   action :start
  # end
end

action :disable do

end

action :delete do

end

def load_current_resource
  extend Bootstrap::Passwd
  @@user = Rtorrent::User.new(new_resource, node)
end
