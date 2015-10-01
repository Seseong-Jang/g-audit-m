#!/bin/sh

if [ $# -ne 1 ]; then
    echo "You must input Mysql Root Password."
    echo "ex) ./stop_audit 1234"
    exit
fi

PW=$1

mysql -uroot -p${PW} --max_allowed_packet=16M -e "SET GLOBAL server_audit_logging=OFF;"
mysql -uroot -p${PW}  --max_allowed_packet=16M -e "SET GLOBAL server_audit_file_path='server_audit.log';"
mysql -uroot -p${PW}  --max_allowed_packet=16M -e "UNINSTALL PLUGIN SERVER_AUDIT;"

echo "======== gm connect logging stoped. ======="
