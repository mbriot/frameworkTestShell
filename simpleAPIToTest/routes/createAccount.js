exports.createAccount = function(req, res){

	//curl -v http://localhost:3000/createAccount -d '{"firstname":"toto","lastname":"tata","email":"toto@toto.com"}'
	
	//generate a random uuid :
	var s = [];
	var hexDigits = "0123456789abcdef";
	for (var i = 0; i < 36; i++) {s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);}
	s[14] = "4";
	s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);
	s[8] = s[13] = s[18] = s[23] = "-";
	var newUserId = s.join("");	
	
	var i =0;
	for(key in req.body){i++;}
	
	//return a 400 Bad Request if the payload is not correct
	if(
	i != 3
	|| !(req.body["lastname"]) 
	|| !(req.body["firstname"])
	|| !(req.body["email"])
	|| req.body["firstname"] == ""
	|| req.body["lastname"] == ""
	|| req.body["email"] == ""
	){
		res.writeHead(400, { "Content-Type": "application/json" });
		res.end("Bad Request");
	//else insert a new user into account.json
	} else {
		var fs = require('fs');
		var data = fs.readFileSync("./account.json"),myObj;
		try {myObj = JSON.parse(data)}
		catch (err) {console.log('There has been an error parsing your JSON.');console.log(err);}
		
		var newUser = '{"userid": "' + newUserId + '","lastname":"' + req.body["lastname"] + '","firstname":"' + req.body["firstname"] + '","email":"' + req.body["email"] + '"}';
		console.log(newUser);
		
		var data = JSON.stringify(myObj);
		data = data.substring(0, data.length - 1) + "," + newUser + "]" ;
		
		//write into account.json
		fs.writeFile("./account.json",data,function (err) {
			if (err) throw err;
			res.writeHead(200, { "Content-Type": "application/json" });
			res.end("{\"userid\" : \"" + newUserId + "\"}");
		});
	}
};