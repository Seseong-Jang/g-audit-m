#!/bin/sh

if [ $# -ne 1 ]; then
    echo "You must input Mysql Root Password."
    echo "ex) ./install_audit 1234"
    exit
fi

mkdir g-audit-logging
cd g-audit-logging
wget https://github.com/Seseong-Jang/g-audit-m/raw/master/g-audit-logging.tar.gz
tar -zxvf g-audit-logging.tar.gz
chown root.root *
cp -f gm_connect_log.so /usr/lib/mysql/plugin/

mkdir -p /backup/log/
touch /backup/log/audit.log

PW=$1

mysql -uroot -p${PW} -e "INSTALL PLUGIN SERVER_AUDIT SONAME 'gm_connect_log.so';"
mysql -uroot -p${PW} -e "SET GLOBAL server_audit_logging=ON;"
mysql -uroot -p${PW} -e "SET GLOBAL server_audit_events=connect;"
mysql -uroot -p${PW} -e "SET GLOBAL server_audit_file_path = /backup/log/audit.log;"

echo "======== gm connect logging installed. ======="
