module Rtorrent
  class User < Bootstrap::User

    def index
      @index ||= node[:system_users].find_index do |username, properties|
        username == @name
      end
      "0#{@index}"
    end

    def rtorrent
      return @rtorrent if @rtorrent

      @resource.rtorrent.each do |key, value|
        @node[:rtorrent][key] = value
      end
      @rtorrent = @node[:rtorrent]
    end

  end
end
