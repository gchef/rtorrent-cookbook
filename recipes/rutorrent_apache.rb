bash "enable Apache modules" do
  code <<-EOH
  a2enmod scgi
  a2enmod auth_digest
  a2enmod ssl
  EOH
  notifies :reload, resources(:service => "apache2"), :immediately
end

template "/etc/apache2/sites-available/rutorrent-ssl" do
  source "rutorrent-ssl.erb"
  mode "0644"
  backup false
end

bash "enable Apache rutorrent-ssl" do
  cwd "/etc/apache2"
  code <<-EOH
  a2dissite default
  a2dissite default-ssl
  a2ensite rutorrent-ssl
  EOH
  notifies :reload, resources(:service => "apache2"), :immediately
end

execute "chown -fR www-data:www-data /var/www/rutorrent"
