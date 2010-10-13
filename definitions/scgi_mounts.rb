define :scgi_mounts do
  mounts = []
  data_bag("users").each do |user|
    index = data_bag_item("users", user)["index"]
    mounts << "SCGIMount /RPC#{index} 127.0.0.1:500#{index}"
  end

  template "/etc/apache2/conf.d/scgi_mounts" do
    source "scgi_mounts.erb"
    mode 0644
    owner "root"
    group "root"
    variables(
      :scgi_mounts => mounts
    )
    backup false
  end
end
