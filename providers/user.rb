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

  # Each user's rtorrent instance is controlled via an upstart job
  #
  service "rtorrent-#{@@user.name}" do
    provider Chef::Provider::Service::Upstart
    supports :restart => true
  end

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
    notifies :restart, resources(:service => "rtorrent-#{@@user.name}"), :delayed
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
    notifies :restart, resources(:service => "rtorrent-#{@@user.name}"), :delayed
  end

  # Ensure user's rtorrent is running
  #
  service "rtorrent-#{@@user.name}" do
    action [:enable, :start]
  end

  if @@user.rtorrent[:rutorrent]
    # rutorrent shared data
    #
    bash "rutorrent shared directory" do
      code %{
        [ ! -d #{@@user.home}/share ] && mkdir #{@@user.home}/share
        [ ! -d #{@@user.home}/share/settings ] && mkdir #{@@user.home}/share/settings

        chown -fR #{@@user.name}: #{@@user.home}/share
        chmod -fR 777 #{@@user.home}/share
        exit 0
      }
    end

    # Setting up rutorrent
    #
    bash "Set up rutorrent v#{node[:rutorrent][:version]} for #{@@user.name}" do
      cwd @@user.home
      code %{
        tar -zxf /usr/local/src/rutorrent-#{node[:rutorrent][:version]}.tar.gz
        rm -fR rutorrent/plugins
        cd rutorrent
        tar -zxf /usr/local/src/plugins-#{node[:rutorrent][:version]}.tar.gz
        [ ! -L share ] && rm -fr share && ln -s #{@@user.home}/share .
        chown -fR #{@@user.name}: #{@@user.home}/rutorrent
        chmod -fR 777 #{@@user.home}/rutorrent
        exit 0
      }
      only_if %{[ ! -d #{@@user.home}/rutorrent ] || [ $(cat #{@@user.home}/rutorrent/js/webui.js | grep -c "version: \\"#{node[:rutorrent][:version]}") = 0 ]}
    end

    template "#{@@user.home}/rutorrent/conf/config.php" do
      cookbook "rtorrent"
      source "rutorrent.config.php.erb"
      owner @@user.name
      group @@user.name
      mode "0777"
      backup false
      variables(
        :user => @@user
      )
    end
  end
end

action :disable do

end

action :delete do

end

def load_current_resource
  require ::File.expand_path('../../../bootstrap/lib/passwd', __FILE__)
  extend Bootstrap::Passwd
  require ::File.expand_path('../../lib/user', __FILE__)
  @@user = Rtorrent::User.new(new_resource, node)
end
