#!/bin/bash
for ((P=1;P<=12;P++))
do
echo 'bloque3/pmm-OpenMP 1280 $P 2 dynamic' | qsub -q ac
done
