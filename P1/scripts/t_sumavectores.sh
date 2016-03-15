#!/bin/bash
for ((N=65536;N<67108865;N=N*2))
do
echo "=== $N ===" >> ../out/t_SumaVectoresC
{ time ../bin/SumaVectoresC $N ; } 2>> ../out/t_SumaVectoresC
echo "=== $N ===" >> ../out/t_SumaVectoresCParallelFor
{ time ../bin/SumaVectoresCParallelFor $N ; } 2>> ../out/t_SumaVectoresCParallelFor
done
