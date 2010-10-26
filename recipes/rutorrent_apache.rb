bash "Enable Apache SCGI" do
  code "a2enmod scgi"
  notifies :reload, resources(:service => "apache2")
  not_if { File.symlink?("/etc/apache2/mods-enabled/scgi.load") }
end

bash "Enable Apache AuthDigest" do
  code "a2enmod auth_digest"
  notifies :reload, resources(:service => "apache2")
  not_if { File.symlink?("/etc/apache2/mods-enabled/auth_digest.load") }
end

bash "Enable Apache SSL" do
  code "a2enmod ssl"
  notifies :reload, resources(:service => "apache2")
  not_if { File.symlink?("/etc/apache2/mods-enabled/ssl.load") }
end

template "/etc/apache2/sites-available/rutorrent-ssl" do
  source "rutorrent-ssl.erb"
  mode "0644"
  backup false
end

bash "Disable Apache default site" do
  cwd "/etc/apache2"
  code "a2dissite default"
  notifies :reload, resources(:service => "apache2")
  not_if { !File.exists?("/etc/apache2/sites-enabled/000-default") }
end

bash "Disable Apache default SSL site" do
  cwd "/etc/apache2"
  code "a2dissite default-ssl"
  notifies :reload, resources(:service => "apache2")
  not_if { !File.exists?("/etc/apache2/sites-enabled/default-ssl") }
end

bash "Enable Apache rutorrent SSL site" do
  cwd "/etc/apache2"
  code "a2ensite rutorrent-ssl"
  notifies :reload, resources(:service => "apache2")
  not_if { File.exists?("/etc/apache2/sites-enabled/rutorrent-ssl") }
end

execute "chown -fR www-data:www-data /var/www/rutorrent"
