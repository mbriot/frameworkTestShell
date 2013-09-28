#!/bin/bash

#get framework properties and framework functions
. ./lib/frameWorkProperties.sh
. ./lib/cw_functions.sh

UNIQUE_ID=`date '+%Y%m%d%H%M%S'`
file="detailResult.txt"

INCREMENT=$1
createDirTest

printTestedPlateforme
printLogFileLocation

EMAIL=${FIRST_NAME}"."${LAST_NAME}+${INCREMENT}@gmail.com
FIRSTNAME=${FIRST_NAME}_${INCREMENT}
LASTNAME=${LAST_NAME}_${INCREMENT}

# TEST DE CREATE ACCOUNT
CONTENT_CREATEACCOUNT="{\"lastname\": \"${LASTNAME}\",\"firstname\": \"${FIRSTNAME}\",\"email\": \"${EMAIL}\"}" 
curlPut $URL /createAccount "$CONTENT_CREATEACCOUNT"

#RECUPERATION DU USERID DANS LOG
USERID=`cat ${HOME_DIRECTORY}/$INCREMENT/$file | tr "," "\n" | grep "userid" |  head -n2 | tail -1| cut -d'"' -f4`
echo " USERID = : $USERID"

# TEST DE GET ACCOUNT INFO
CONTENT_GETACCOUNT='{"userid":"'$USERID'"}'
curlPutCWWithTarget $URL getAccountInfo "$CONTENT_GETACCOUNT" $USERID

printLogFileLocation
