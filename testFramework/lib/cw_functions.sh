#!/bin/bash

#RECUPERATION DES PROPERTIES
. ./frameWorkProperties.sh

#FONCTION REQUETE CURL + LOG
curlFunction(){
	URL=$1
	SERVICE=$2
	DATA=$3
	HEADER=$4
	
	echo -e " " |tee -a ${HOME_DIRECTORY}/$INCREMENT/$file
	echo -e "Test de $2 \n " |tee -a ${HOME_DIRECTORY}/$INCREMENT/$file
	echo -e "curl -H \"X-CORRELATIONID: ${CORRELATIONID}\" -H 'X-USERID-TECH:TestCurl' $HEADER -H \"Content-type: application/json\"  -X \"POST\"  -d '"$DATA"' ${1}/${2}" | tee -a ${HOME_DIRECTORY}/$INCREMENT/$file
	echo -e "INPUT : \n $3" |tee -a ${HOME_DIRECTORY}/$INCREMENT/$file
	echo -e "OUTPUT : " |tee -a ${HOME_DIRECTORY}/$INCREMENT/$file
	curl -w "\n HTTP CODE : %{http_code}" -D ${HOME_DIRECTORY}/$INCREMENT/header/${SERVICE}.headersOut -H "X-CORRELATIONID:${CORRELATIONID}"  -H 'X-USERID-TECH:TestCurl' -H 'X-USERID-TARGET:TestCurl'  $HEADER -H "Content-type: application/json" -X "POST"  -d "$DATA" ${1}/${2} | tee -a ${HOME_DIRECTORY}/$INCREMENT/$file
	echo -e " " |tee -a ${HOME_DIRECTORY}/$INCREMENT/$file
	
	getHttpCodeStatus
}

printLogFileLocation( ){
	echo -e "fichier de destination : ${HOME_DIRECTORY}/$INCREMENT/${file}"
}

printTestedPlateforme(){
	echo -e "Tests réalisés sur : $URL " | tee -a ${HOME_DIRECTORY}/$INCREMENT/$file
}

getHttpCodeStatus(){
	RETURNSTATUS="KO"
	RETURNCODE=`cat ${HOME_DIRECTORY}/$INCREMENT/header/${SERVICE}.headersOut | grep "HTTP/1.1" | cut -d' ' -f2`

	if [ $RETURNCODE == "200" ];then
		RETURNSTATUS="OK"
	fi
	echo -e "$SERVICE : $RETURNCODE : $RETURNSTATUS" >> ${HOME_DIRECTORY}/$INCREMENT/finalResult.txt
}

createDirTest(){
	cd ${HOME_DIRECTORY}
	mkdir $INCREMENT
	cd $INCREMENT
	mkdir header
}