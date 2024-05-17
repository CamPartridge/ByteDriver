const emailAPI = require('./emailAPI.js')

function composeEmail(key, value) {
    switch (key) {
        case "newUser":
            newUserEmail(JSON.parse(value))
            break;
        case "deleteUser":
            deleteUserEmail(JSON.parse(value))
            break;
        case "updateUser":
            updateUserEmail(JSON.parse(value))
            break;
        default:
            console.log("pretend theres an email")
            break;
    }
}

function newUserEmail(value) {
    var email = value.Email
    var subject = "Account created"
    var message = "Welcome " + value.FirstName+ " "+ value.LastName + ":)\nThank you for registering your account"

    emailAPI.SendEmail(email, subject, message)
}

function deleteUserEmail(value) {
    var email = value.Email
    var subject = "Account Successfully Deleted"
    var message = "Goodbye " + value.UserName + ".\nWe are sad to see you go :("

    emailAPI.SendEmail(email, subject, message)
}

function updateUserEmail(value) {
    var email = value.Email
    var subject = "Account Details have been changed"
    var message = "Your account has been updated: \nUsername: " + value.UserName +
        "\nEmail: " + value.Email + "\nPassword: " + value.Password + "\nAddress: " + value.Address;

    emailAPI.SendEmail(email, subject, message)
}

function orderAccepted(value){
    var email = value.Email
    var subject = "Your Order has been accepted"
    var message = "Your Order has been accepted by Driver " + value.FirstName + " " + value.LastName 
    emailAPI.SendEmail(email,subject,message)
}

module.exports = {
    ComposeEmail: composeEmail
};