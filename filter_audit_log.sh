#!/bin/bash

# need root permission
cat /data/log/audit.log | grep FAILED | grep -v "172.16.100.21" >> `hostname`_audit.log
cat /dev/null > /data/log/audit.log

expect -c "
        set timeout 600
        spawn rsync -avr -e ssh `hostname`_audit.log gamevil@172.18.100.22:/home/gamevil/audit_cw3_log/
        expect {
                -nocase yes/no {
                        send yes\r
                        expect eof
                }
                -nocase password: {
                        send rpaqlf\r
                        expect eof
                }
        }
        exit
"