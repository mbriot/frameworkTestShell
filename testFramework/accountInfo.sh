#!/bin/bash

# TEST DE CHECK EMAIL EXISTS
# TEST DE GET ACCOUNT INFO

#RECUPERATION DES PROPERTIES
. ~/.cloudwatt/CwProperties.sh

#INCLUSION DES FONCTIONS
. ./lib/cw_functions.sh

UNIQUE_ID=`date '+%Y%m%d%H%M%S'`
file="${UNIQUE_ID}.txt"

printTestedPlateforme
printLogFileLocation

EMAIL=$1

# TEST DE CHECK EMAIL EXISTS
CONTENT_CHECKEMAILEXISTS="{\"email\": \"${EMAIL}\"}"
curlPut $URL checkEmailExists "$CONTENT_CHECKEMAILEXISTS"

#récupération du champ USERID dans les logs
USERID=`cat ${HOME_DIRECTORY}/$file | tr "," "\n" | grep "userid" | head -n1 | cut -d'"' -f4`

# TEST DE GET ACCOUNT INFO
CONTENT_GETACCOUNT='{"userid":"'$USERID'"}'
curlPutCWWithTarget $URL getAccountInfo "$CONTENT_GETACCOUNT" $USERID

printLogFileLocation