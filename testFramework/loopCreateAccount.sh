#!/bin/bash

PREFIX=$1
NBRE_ITERATION=$2

for ((i=1;i<=${NBRE_ITERATION};i++))
do
        ./createAccount.sh ${PREFIX}${i}
        
done

