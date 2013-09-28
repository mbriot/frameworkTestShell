var express = require('express');
var routes = require('./routes');
var createAccount = require('./routes/createAccount');
var getAccountInfo = require('./routes/getAccountInfo');
var http = require('http');

var app = express();

// all environments
app.set('port', 3000);
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);

app.post('/createAccount', createAccount.createAccount);
app.get('/getAccountInfo/:userid', getAccountInfo.getAccountInfo);

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
