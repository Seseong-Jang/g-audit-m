#!/bin/bash

LOG_PATH=/data/mysql/server_audit.log

# need root permission
cat ${LOG_PATH} | grep FAILED | grep -v "172.16.100.21" >> /backup/audit/`hostname`_audit.log
cat /dev/null > ${LOG_PATH}

#expect -c "
#        set timeout 600
#        spawn rsync -avr -e ssh `hostname`_audit.log gamevil@172.18.100.22:/home/gamevil/audit_cw3_log/
#        expect {
#                -nocase yes/no {
#                        send yes\r
#                        expect eof
#                }
#                -nocase password: {
#                        send rpaqlf\r
#                        expect eof
#                }
#        }
#        exit
#"
