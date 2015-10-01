#!/bin/sh

# copy audit library file to mysql plugin folder
sudo cp gm_connect_log.so /usr/lib/mysql/plugin

# backup origin my.cnf
sudo cp /etc/mysql/my.cnf /etc/mysql/my.cnf.bak

# add parameter for mysql audit logging (my.cnf)
sudo (sed '/\[Mysqld\]/a plugin-load = server_audit=gm_connect_log.so\nserver_audit_events = connect\nserver_audit_logging = ON\nserver_audit_file_path = /backup/log/audit.log' /etc/mysql/my.cnf.bak) > /etc/mysql/my.cnf

# create audit log file
sudo touch /backup/log/audit.log

# restart service
#sudo /etc/init.d/mysql restart
