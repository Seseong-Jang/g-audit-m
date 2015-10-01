#!/bin/sh

if [ $# -ne 1 ]; then
    echo "You must input Mysql Root Password."
    echo "ex) ./stop_audit 1234"
    exit
fi

PW=$1

mysql -uroot -p${PW} -e "SET GLOBAL server_audit_logging=OFF;"

echo "======== gm connect logging stoped. ======="
