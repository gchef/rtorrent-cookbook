actions :create, :disable, :delete

attribute :username,       :kind_of => String,  :name_attribute => true
attribute :password,       :kind_of => String,  :default => ''
attribute :home_basepath,  :kind_of => String,  :default => '/home'
attribute :rtorrent,       :kind_of => Hash,    :default => {}

def initialize(*args)
  super
  @action = :create
end
