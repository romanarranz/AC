#!/bin/bash
# uso upload_ssh.sh fichero dir_remoto
# dir_remoto partiendo del path de inicio del login de usuario ssh
HOST="atcgrid.ugr.es"
USER="B3estudiante3"
PASS="pmngsbnhtz"
FICHEROS=$1
DIRECTORIO_REMOTO=$2
 
VAR=$(expect -c "
spawn scp -r $FICHEROS $USER@$HOST:$DIRECTORIO_REMOTO
match_max 100000
expect \"*?assword:*\"
send -- \"$PASS\r\"
send -- \"\r\"
expect eof
")
echo "==============="
echo "$VAR"