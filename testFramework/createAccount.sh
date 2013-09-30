#!/bin/bash

#get framework properties and framework functions
. ./lib/frameWorkProperties.sh
. ./lib/cw_functions.sh

file="detailResult.txt"
INCREMENT=$1

createDirTest
printTestedPlateform
printLogFileLocation

EMAIL=${FIRST_NAME}"."${LAST_NAME}@gmail.com
FIRSTNAME=${FIRST_NAME}
LASTNAME=${LAST_NAME}

#createAccount test
CONTENT_CREATEACCOUNT="{\"lastname\": \"${LASTNAME}\",\"firstname\": \"${FIRSTNAME}\",\"email\": \"${EMAIL}\"}" 
curlFunction $URL createAccount "$CONTENT_CREATEACCOUNT"

#retrieve userid from log
USERID=`cat ${HOME_DIRECTORY}/$INCREMENT/$file | tr "," "\n" | grep "userid" |  head -n2 | tail -1| cut -d'"' -f4`
echo " USERID = : $USERID"

#getAccountInfo test
curlFunction $URL getAccountInfo/$USERID