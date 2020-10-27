#!/usr/bin/env sh

mysql -uroot -p $MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < ./db.sql
