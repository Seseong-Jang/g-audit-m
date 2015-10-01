#!/bin/sh

if [ $# -ne 1 ]; then
    echo "You must input Mysql Root Password."
    echo "ex) ./install_audit 1234"
    exit
fi

PW=$1
PLUGIN_DIR=`mysql -uroot -p${PW} --max_allowed_packet=16M -N -e"show variables like 'plugin_dir'" | grep mysql | awk '{print $2}'`

chown root.root *
cp -f gm_connect_log.so ${PLUGIN_DIR}

mkdir -p /backup/audit/
touch /backup/audit/audit.log

mysql -uroot -p${PW} --max_allowed_packet=16M -e "INSTALL PLUGIN SERVER_AUDIT SONAME 'gm_connect_log.so';"
mysql -uroot -p${PW} --max_allowed_packet=16M -e "SET GLOBAL server_audit_logging=ON;"
mysql -uroot -p${PW} --max_allowed_packet=16M -e "SET GLOBAL server_audit_events=connect;"
mysql -uroot -p${PW} --max_allowed_packet=16M -e "SET GLOBAL server_audit_file_path = /backup/audit/audit.log;"

echo "======== gm connect logging installed. ======="
