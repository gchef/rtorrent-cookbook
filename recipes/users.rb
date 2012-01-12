include_recipe "bootstrap::users"

node[:system_users].each do |username, properties|
  next unless properties.has_key?(:rtorrent)

  rtorrent_user username do
    password          properties[:password]
    home_basepath     properties[:home_basepath]
    rtorrent          properties[:rtorrent]
    action            properties[:status]
  end
end
