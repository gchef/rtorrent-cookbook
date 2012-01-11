node[:rtorrent][:package_dependencies].each do |name|
  package name
end

bash "SVN checkout xmlrpc-c" do
  cwd "/usr/local/src"
  code <<-EOH
  svn co https://xmlrpc-c.svn.sourceforge.net/svnroot/xmlrpc-c/advanced xmlrpc-c
  cd xmlrpc-c
  ./configure --disable-cplusplus
  make && make install
  EOH
  not_if "which xmlrpc-c-config"
end
