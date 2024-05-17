const nodemailer = require('nodemailer');


function SendEmail(email, subject, messageContent) {

    nodemailer.createTestAccount((error, account) => {
        if (error) {
            console.error('Failed to create a testing account. ' + error.message);
            return process.exit(1);
        }

        
        let transporter = nodemailer.createTransport({
            host: account.smtp.host,
            port: account.smtp.port,
            secure: account.smtp.secure,
            auth: {
                user: account.user,
                pass: account.pass
            }
        });

        // Message object
        let message = {
            from: 'ByteDriver@gmail.com', // your sites email
            to: email,
            subject: subject,
            text: messageContent,
            html: `<p>${messageContent}</p>`
        };

        transporter.sendMail(message, (err, info) => { // sends the email
            if (err) {
                console.log('Error occurred. ' + err.message);
                return process.exit(1);
            }

            console.log('Message sent: %s', info.messageId);
            console.log('Preview URL: %s', nodemailer.getTestMessageUrl(info));
        });
    });
}

module.exports = {
  SendEmail
};