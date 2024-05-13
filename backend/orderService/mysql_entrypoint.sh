#!/bin/bash

set -e

if [ "$1" = 'mysqld' ]; then

  # If this is the container's first run, initialize the application database
  if [ ! -f /tmp/app-initialized ]; then
    # Initialize the application database asynchronously in a background process
    function initialize_app_database() {
      # Wait a bit for MySQL to start
      sleep 15s
      # Run the setup script to create the DB and schema in the DB
      mysql -u root -p$MYSQL_ROOT_PASSWORD < /docker-entrypoint-initdb.d/mysql_setup_orderDB.sql
      # Note that the container has been initialized so future starts won't wipe changes to the data
      touch /tmp/app-initialized
    }
    initialize_app_database &
  fi
fi

exec "$@"