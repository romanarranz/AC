#!/bin/bash
for ((P=1;P<=4;P++))
do
../bin/pmm-OpenMP 1280 $P 2 dynamic > "file$P"
done
