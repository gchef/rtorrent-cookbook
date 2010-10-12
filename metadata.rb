maintainer       "Gerhard Lazu"
maintainer_email "gerhard@lazu.co.uk"
license          "Apache 2.0"
description      "Installs & configures rtorrent. Separate recipe for rutorrent v3.1"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1.0"

depends "build-essential"
depends "sysadmin"
depends "ruby"
depends "apache2"
depends "apache2::mod_php5"
