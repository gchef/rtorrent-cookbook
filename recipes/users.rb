node[:system_users].each do |username, user|
  rtorrent_user username do
    user.each do |attribute, value|
      instance_variable_set("@#{attribute}", value)
    end
  end
end

