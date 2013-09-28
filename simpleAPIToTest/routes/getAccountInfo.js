exports.getAccountInfo = function(req, res){

	//userid from getAccountInfo/:userid
	userToRetrieve = req.params.userid ;

	//get account.json into accountData variable
	var fs = require('fs'),readline = require('readline');
	var data = fs.readFileSync('./account.json'),accountData;
	try {accountData = JSON.parse(data)}
	catch (err) {
		console.log('There has been an error parsing your JSON.');
		console.log(err);}

	//seach for key containing userToRetrieve
	var accountInfo = "" , userFound = false;
	for(key in accountData){
		if(userToRetrieve == accountData[key]["userid"]){
			accountInfo = accountData[key];
			userFound = true;
		}
	}

	//return 404 User Unknown if userid not found into account.json
	var statusCode = 0, message = "";
	if(userFound) {statusCode = 200 ; message = JSON.stringify(accountInfo);}
	else {statusCode = 404 ; message = "User Unknown"}

	res.writeHead(statusCode, { "Content-Type": "application/json" });
	res.end(message);

};