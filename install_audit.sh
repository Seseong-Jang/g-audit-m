#!/bin/sh

if [ $# -ne 2 ]; then
    echo "You must input Mysql Root Password And OS type(CentOS | Ubuntu)."
    echo "ex) ./install_audit 1234 CentOS"
    exit
fi

# install package for rsync, expect
case $2 in
    "CentOS")
         yum install -y rsync
         yum install -y expect
	 yum install -y cronie
	 /etc/init.d/crond restart
         ;;
    "Ubuntu")
         apt-get install -y rsync
         apt-get install -y expect
         ;;
    *)
         echo "Error input parameter must input CentOS or Ubuntu."
         ;;
esac

PW=$1
PLUGIN_DIR=`mysql -uroot -p${PW} --max_allowed_packet=16M -N -e"show variables like 'plugin_dir'" | grep mysql | awk '{print $2}'`
echo "plugin_dir is ${PLUGIN_DIR}"

chown root.root *
cp -f gm_connect_log.so ${PLUGIN_DIR}
echo "copy so file to ${PLUGIN_DIR}"

mkdir -p /backup/audit/
#touch /backup/audit/audit.log
#echo "default folder and file create"

mysql -uroot -p${PW} --max_allowed_packet=16M -e "INSTALL PLUGIN SERVER_AUDIT SONAME 'gm_connect_log.so';"
mysql -uroot -p${PW} --max_allowed_packet=16M -e "SET GLOBAL server_audit_events=connect;"
mysql -uroot -p${PW} --max_allowed_packet=16M -e "SET GLOBAL server_audit_logging=ON;"
mysql -uroot -p${PW} --max_allowed_packet=16M -e "SET GLOBAL server_audit_file_rotate_size=10000000;"
#mysql -uroot -p${PW} --max_allowed_packet=16M -e "SET GLOBAL server_audit_file_path = '/backup/audit/audit.log';"

echo "======== gm connect logging installed. ======="

# copy script to /root
cp filter_audit_log.sh /root

# crontab install
cp -f filter_cron /etc/cron.d/
echo "======== crontab installed audit_loggin filter"
