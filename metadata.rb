# Encoding: UTF-8

name             'docker-runit'
maintainer       'Justin Haynes'
maintainer_email 'sysadmin@socrata.com'
license          'All rights reserved'
description      'LWRP for running a docker container via runit'
long_description 'LWRP for running a docker container via runit'
version          '0.1.0'

depends          'runit'
depends          'docker'

supports         'ubuntu'