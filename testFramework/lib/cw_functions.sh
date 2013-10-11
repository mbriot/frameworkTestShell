#!/bin/bash

#RECUPERATION DES PROPERTIES
. ./lib/frameWorkProperties.sh

#FONCTION REQUETE CURL + LOG
curlFunction(){
	METHOD=$1
	URL=$2
	SERVICE=$3
	DATA=$4
	
	echo -e " " |tee -a ${HOME_DIRECTORY}/$INCREMENT/$file
	echo -e "Test de ${SERVICE} \n " |tee -a ${HOME_DIRECTORY}/$INCREMENT/$file
	echo -e "curl -H \"Content-type: application/json\"  -X $METHOD                                                                                                                                         -d '"$DATA"' ${URL}/${SERVICE}" | tee -a ${HOME_DIRECTORY}/$INCREMENT/$file
	echo -e "INPUT : \n ${DATA}" |tee -a ${HOME_DIRECTORY}/$INCREMENT/$file
	echo -e "OUTPUT : " |tee -a ${HOME_DIRECTORY}/$INCREMENT/$file
	curl -w "\n HTTP CODE : %{http_code}" -s -D ${HOME_DIRECTORY}/$INCREMENT/header/${SERVICE}.headersOut -H "Content-type: application/json" -X $METHOD  -d "$DATA" ${URL}/${SERVICE} | tee -a ${HOME_DIRECTORY}/$INCREMENT/$file
	echo -e " " |tee -a ${HOME_DIRECTORY}/$INCREMENT/$file
}

printLogFileLocation( ){
	echo -e "destination file : ${HOME_DIRECTORY}/$INCREMENT/${file}"
}

printTestedPlateform(){
	echo -e "Tests realised on : $URL " | tee -a ${HOME_DIRECTORY}/$INCREMENT/$file
}

createDirTest(){
	cd ${HOME_DIRECTORY}
	mkdir $INCREMENT && cd $INCREMENT
	mkdir header
}