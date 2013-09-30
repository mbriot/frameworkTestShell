#!/bin/bash

NBRE_ITERATION=$2

for ((i=1;i<=${NBRE_ITERATION};i++))
do
        ./createAccount.sh ${i}
        
done

