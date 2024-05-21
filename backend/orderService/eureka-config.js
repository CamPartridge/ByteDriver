const { Eureka } = require('eureka-js-client');

// Configuration for Eureka client
const client = new Eureka({
  instance: {
    app: 'orderService',
    instanceId: 'orderService', 
    hostName: 'orderService',
    ipAddr: '0.0.0.0',
    port: {
      '$': 8086, // The port your service is running on
      '@enabled': 'true',
    },
    vipAddress: 'orderService', // The VIP address for your service
    statusPageUrl: 'http://localhost:8080/', // Health check url
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
