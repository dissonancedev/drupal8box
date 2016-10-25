#!/bin/bash

# Start the services
service php7.0-fpm start
service memcached start

# Start nginx which has daemon: off; in it's configuration
# so it will run in the foreground and keep the container running
nginx
