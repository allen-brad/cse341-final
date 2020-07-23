const express = require('express');
const app = express();
const morgan = require('morgan');
const bodyParser = require('body-parser');
require('dotenv').config();
const { Pool } = require("pg"); // This is the postgres database connection module.
const connectionString = process.env.DATABASE_URL;
const pool = new Pool({
    connectionString: process.env.DATABASE_URL ,
    ssl: {
      rejectUnauthorized: false
    }
  });
  
const membersRoutes = require('./api/routes/members');
const eventsRoutes = require('./api/routes/events');

//logging
app.use(morgan('dev'));
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

//deal with CORs
app.use((req, res, next) =>{
    res.header("Access-Control-Allow-Origin","*");
    res.header(
        "Access-Control-Allow-Headers",
        "Origin, X-Requested-With, Content-Type, Accept, Authorization"
    );
    if(req.method === 'OPTIONS'){
        res.header('Access-Control-Allow-Methods', 'PUT, POST, PATCH, DELETE, GET');
        return res.status(200).json({});
    }
    next();
});

// static files
app.use(express.static(__dirname + '/public'));

//forward member requests to member route
app.use('/members',membersRoutes);
app.use('/events',eventsRoutes);

app.use((req, res, next) =>{
    const error = new Error('Not found');
    error.status =404;
    next(error);    
});

app.use((error, req, res, next) =>{
    res.status(error.status || 500);
    res.json({
        error: {
            message: error.message
        }
    });
});

module.exports = app;
