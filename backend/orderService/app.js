var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var orderRoute = require('./routes/orderRoute')
const eurekaClient = require('./eureka-config.js');

eurekaClient.start(error => {
    if (error) {
      console.error('Error starting Eureka client', error);
    } else {
      console.log('Eureka client started');
    }
});

var app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/order', orderRoute);

module.exports = app;
