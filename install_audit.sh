#!/bin/sh

if [ $# -ne 1 ]; then
    echo "You must input Mysql Root Password."
    echo "ex) ./install_audit 1234"
    exit
fi

PW=$1
PLUGIN_DIR=`mysql -uroot -p${PW} -N -e"show variables like 'plugin_dir'" | grep mysql | awk '{print $2}'`

chown root.root *
cp -f gm_connect_log.so /usr/lib/mysql/plugin/

mkdir -p /backup/log/
touch /backup/log/audit.log

mysql -uroot -p${PW} -e "INSTALL PLUGIN SERVER_AUDIT SONAME 'gm_connect_log.so';"
mysql -uroot -p${PW} -e "SET GLOBAL server_audit_logging=ON;"
mysql -uroot -p${PW} -e "SET GLOBAL server_audit_events=connect;"
mysql -uroot -p${PW} -e "SET GLOBAL server_audit_file_path = /backup/log/audit.log;"

echo "======== gm connect logging installed. ======="
