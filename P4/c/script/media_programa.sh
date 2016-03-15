#!/bin/zsh
if [[ $# == 2 ]]; then	
	program=$1
	N=$2
	media=0;
	for ((P=0;P<$N;P++))
	do
		resultado=`$program|tail -1`
		media=$(($media+$resultado))
	done
	media=$(($media/$N))
	echo $media
else
	echo "Error: media_programa.sh <programa_ac.c> <iteraciones>"
	echo "El programa escrito en c tiene que tener como ultima linea el tiempo de ejecucion del calculo para obtener la media"
	echo "Ejemplo: media_programa.sh sumavector.c 10"
	echo "Tamaño Vector = 20"
	echo "Tiempo = 0.28272"
	echo "=> 0.28272"
fi