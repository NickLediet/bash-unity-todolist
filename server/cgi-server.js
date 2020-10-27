const cgi = require('cgi');
const http = require('http');
const path = require('path');

const PORT = process.env.PORT || 8080

const script = path.resolve(__dirname, 'router.sh');

http.createServer( cgi(script) ).listen(PORT);
