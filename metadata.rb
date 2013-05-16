name             "rtstps-cookbook"
maintainer       "Scott Macfarlane"
maintainer_email "scott@gina.alaska.edu"
license          "All rights reserved"
description      "Installs/Configures rtstps-cookbook"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.1.0"

depends "java"
suggests "dbvm"

supports "centos", "> 6.0"