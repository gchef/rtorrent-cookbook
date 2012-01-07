maintainer       "Gerhard Lazu"
maintainer_email "gerhard@lazu.co.uk"
license          "Apache 2.0"
description      "Installs & configures rtorrent & rutorrent. Apache only for now, will be looking into nginx support eventually."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "1.1.0"

depends "apache2" # https://github.com/gchef/apache2-cookbook
depends "apt" # https://github.com/gchef/apt-cookbook
depends "build-essential"

recipe  "rtorrent", "General setup"
recipe  "rtorrent::rutorrent", "rutorrent web gui"
recipe  "rtorrent::rutorrent_apache", "Apache specific rutorrent setup"
