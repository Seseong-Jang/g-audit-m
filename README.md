# g-audit-m #

###### extract tar.gz file ######
tar -zxvf g-audit-logging.tar.gz

###### install g-audit-m ######
run install_audit.sh {ROOT_PW}

###### stop g-audit-m ######
run stop_audit.sh {ROOT_PW}

###### for scheduling script - filtering failed connect log ######
run filter_audit_log.sh
