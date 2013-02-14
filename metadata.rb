maintainer       "Gerhard Lazu"
maintainer_email "gerhard@lazu.co.uk"
license          "Apache 2.0"
description      "Installs & configures rtorrent & rutorrent."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "2.0.1"

depends "apt" # https://github.com/gchef/apt-cookbook
depends "bootstrap" # https://github.com/gchef/bootstrap-cookbook
depends "build-essential"

recipe  "rtorrent", "General setup"
recipe  "rtorrent::rutorrent", "rutorrent web gui"
