require ::File.expand_path('../../../bootstrap/lib/user', __FILE__)

module Rtorrent
  class User < ::Bootstrap::User

    def rtorrent
      return @rtorrent if @rtorrent

      @node[:rtorrent].each do |key, value|
        @resource.rtorrent[key] ||= value
      end
      @rtorrent = @resource.rtorrent
    end

  end
end
