const http = require('http');
const app = require('./app');

const port = (process.env.port || 5000) ;

app.set('port', (process.env.PORT || 5000));

const server = http.createServer(app);

server.listen(app.get('port'), function() {
    console.log('Node app is running on port', app.get('port'));
});
