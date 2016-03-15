#!/bin/bash
# sudo apt-get install expect
HOST="atcgrid.ugr.es"
USER="B3estudiante3"
PASS="pmngsbnhtz"
CMD=$@
VAR=$(expect -c "
spawn ssh -o StrictHostKeyChecking=no $USER@$HOST $CMD
match_max 100000
expect \"*?assword:*\"
send -- \"$PASS\r\"
send -- \"\r\"
expect eof
")
echo "==============="
echo "$VAR"