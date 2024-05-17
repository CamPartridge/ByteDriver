const { Kafka } = require('kafkajs');

const kafka = new Kafka({
    clientId: 'NotificationService', // Name as you want
    brokers: ['kafka:9092'], // <ContainerName>:<ExposedPort>
});

const producer = kafka.producer();

exports.SendEmail = async function (topic, key, jsonValue) {
    console.log('Entered SendEmail');
    console.log('Sending message: ', jsonValue);
    try {
        await producer.connect(); 
        await producer.send({ 
            topic: topic,
            messages: [
                { key: key, value: jsonValue },
            ],
        });
    } catch (error) {
        console.error('Error sending message:', error);
    }
};

module.exports = {
    sendEmail: this.SendEmail
};