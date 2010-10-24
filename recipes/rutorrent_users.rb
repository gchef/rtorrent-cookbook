data_bag("users").each do |user|
  properties = data_bag_item("users", user)
  name = properties["id"]
  index = properties["index"]

  if File.directory?('/etc/apache2')
    apache2conf = File.read('/etc/apache2/apache2.conf')
    unless apache2conf.include? "127.0.0.1:500#{index}"
      File.open('/etc/apache2/apache2.conf', 'a') { |f| f.puts "SCGIMount /var/www/rutorrent/RPC#{index} 127.0.0.1:500#{index}" }
    end

    file "/etc/apache2/.passwds" do
      mode 0644
      action :create_if_missing
      backup false
    end

    # printf "<user>:<realm>:<real-password>" | md5sum
    if File.exists?('/etc/apache2/.passwds')
      htdigest = properties["htdigest"]
      apache2passwds = File.read('/etc/apache2/.passwds')
      unless apache2passwds.include? htdigest
        File.open('/etc/apache2/.passwds', 'a') { |f| f.puts "#{name}:Authorized:#{htdigest}" }
      end
    end

    scgi_mounts
  end

  directory "/var/www/rutorrent/conf/users/#{name}" do
    owner "www-data"
    group "www-data"
    mode 0755
  end

  template "/var/www/rutorrent/conf/users/#{name}/access.ini" do
    source "rutorrent.access.ini.erb"
    owner "www-data"
    group "www-data"
    mode 0755
    backup false
  end

  template "/var/www/rutorrent/conf/users/#{name}/plugins.ini" do
    source "rutorrent.plugins.ini.erb"
    owner "www-data"
    group "www-data"
    mode 0755
    backup false
  end

  template "/var/www/rutorrent/conf/users/#{name}/config.php" do
    source "rutorrent.config.php.erb"
    owner "www-data"
    group "www-data"
    mode 0755
    backup false
    variables(
      :name => name,
      :port => "500#{index}",
      :rpc => "RPC#{index}"
    )
  end
end
