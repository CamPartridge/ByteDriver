const { Kafka } = require('kafkajs');
const email = require('./emailCompose.js')

const kafka = new Kafka({
  clientId: 'NotificationService', // Name as you want
  brokers: ['kafka:9092'], // <ContainerName>:<ExposedPort>
  connectionTimeout: 30000, // Increase connection timeout
  retry: {
    retries: 10 // Increase number of retries
  }
});

const consumer = kafka.consumer({ groupId: 'NotificationService' }); // groupe id = anything you want

const run = async function () {
  try {
    console.log("trying to run")
    await consumer.connect(); //connects to the stream

    await consumer.subscribe({ topic: 'Users', fromBeginning: true });
    await consumer.subscribe({ topic: 'Orders', fromBeginning: true });
    await consumer.run({
      eachMessage: async ({ topic, partition, message, heartbeat, pause }) => { // handles the message
        console.log('Received message', {
          topic,
          partition,
          key: message.key.toString(),
          value: message.value.toString(),
        });
        // Handle message

        email.ComposeEmail(message.key.toString(), message.value.toString())

        JSON.parse(message.value).ID // would get the proporty Id for refrence
        
      },
    });
  } catch (error) {
    console.error('Error running consumer:', error);
  }
};

run().catch(console.error);