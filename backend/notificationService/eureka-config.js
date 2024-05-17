const { Eureka } = require('eureka-js-client');

// Configuration for Eureka client
const client = new Eureka({
  instance: {
    app: 'notificationService', 
    hostName: 'localhost',
    ipAddr: '127.0.0.1',
    port: {
      '$': 8085, // The port your service is running on
      '@enabled': 'true',
    },
    vipAddress: 'notificationService', // The VIP address for your service
    dataCenterInfo: {
      '@class': 'com.netflix.appinfo.InstanceInfo$DefaultDataCenterInfo',
      name: 'MyOwn', // Specify your data center info
    },
  },
  eureka: {
    host: 'eurekaRegistry', // Hostname of your Eureka server
    port: 8761, // Port of your Eureka server
    servicePath: '/eureka/apps', // The service path for Eureka
  },
});

module.exports = client;
