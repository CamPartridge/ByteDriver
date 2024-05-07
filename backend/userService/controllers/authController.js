const security = require('../security/password.js')
const { UniqueConstraintError } = require('sequelize')

const authController = {
    register: async (req, res, next) => {
        try {
            const emailRegex = new RegExp('(.+)@(.+){2,}\.(.+){2,}') // match any string that consists of at least one character, followed by an at symbol, followed by at least two characters, followed by a dot, followed by at least two characters
            const passwordRegex = new RegExp('^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{6,16}$') //match any string that consists of at least 6 characters and at most 16 characters, includes at least one digit and at least one special character, and only contains letters, digits, and the special characters !@#$%^&*

            if (emailRegex.test(req.body.Email)) {
                if (passwordRegex.test(req.body.Password)) {
                    req.body.Password = security.hashPassword(req.body.Password)
                    next()
                } else {
                    throw new Error('Invalid password');
                }
            } else {
                throw new Error('Invalid email');
            }
        } catch (error) {
            if (error instanceof UniqueConstraintError) {
                res.status(409).send("Username or Phone Number already exists")
            } else if (error.message === 'Invalid email') {
                res.status(401).send("Invalid Email")
            } else if (error.message === 'Invalid password') {
                res.status(401).send("Invalid Password")
            } else {
                res.status(500).send(error)
            }
        }
    }, 
    login: async (req, res) => {
        const user = res.locals.User[0]

        if (user.PhoneNumber === req.body.PhoneNumber) {
            if (security.comparePassword(req.body.Password, user.Password)) {
                delete user.dataValues.Password;
                res.status(200).send(user)
            } else {
                res.status(401).send("Incorrect Password")
            }
        } else {
            res.status(401).send("Phone Number not found")
        }
    },

}

module.exports = authController