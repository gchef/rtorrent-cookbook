service "apache2"

template "/etc/apache2/sites-available/rutorrent" do
  source "rutorrent.conf.erb"
  mode "0644"
  backup false
end

bash "Enable Apache rutorrent site" do
  cwd "/etc/apache2"
  code "a2ensite rutorrent"
  notifies :restart, resources(:service => "apache2")
  not_if { File.exists?("/etc/apache2/sites-enabled/rutorrent") }
end
