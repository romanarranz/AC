#!/bin/bash
# uso download_ssh.sh dir_remoto/fichero1 dir_remoto/fichero2
# ./download_ssh.sh "bloque0/HelloOMP"
HOST="atcgrid.ugr.es"
USER="B3estudiante3"
PASS="pmngsbnhtz"
CMD=$@
 
VAR=$(expect -c "
spawn scp -r $USER@$HOST:$CMD .
match_max 100000
expect \"*?assword:*\"
send -- \"$PASS\r\"
send -- \"\r\"
expect eof
")
echo "==============="
echo "$VAR"