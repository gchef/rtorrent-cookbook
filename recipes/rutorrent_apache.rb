service "apache2"

bash "Enable Apache SCGI" do
  code "a2enmod scgi"
  notifies :restart, resources(:service => "apache2")
  not_if { File.symlink?("/etc/apache2/mods-enabled/scgi.load") }
end

file "/etc/apache2/conf.d/scgi_mounts" do
  mode "0644"
  action :create_if_missing
  backup false
end

bash "Disable Apache default site" do
  cwd "/etc/apache2"
  code "a2dissite default"
  notifies :restart, resources(:service => "apache2")
  not_if { !File.exists?("/etc/apache2/sites-enabled/000-default") }
end

bash "Disable Apache default SSL site" do
  cwd "/etc/apache2"
  code "a2dissite default-ssl"
  notifies :restart, resources(:service => "apache2")
  not_if { !File.exists?("/etc/apache2/sites-enabled/default-ssl") }
end

execute "chown -fR www-data:www-data /var/www"
