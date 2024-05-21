const { UniqueConstraintError } = require('sequelize')
const  User = require("../models/user.js")
var { sendEmail } = require("../producer.js")

const userController = {
    create: async (req, res, next) => {
        try {
            const { FirstName, LastName, Email} = req.body;
            const UserID = req.body.ByterID || req.body.UserID
            console.log(UserID)

            const user = await User.findOrCreate({
                where: {
                    UserID
                },
                defaults: {
                UserID,
                FirstName, 
                LastName,
                Email}
            })


            res.locals.User = user

            next()

        } catch (error){
            if (error instanceof UniqueConstraintError) {
                res.status(409).send("Unique information already exists in DB")
            }
            else {
                res.status(500).send("In userController.create: " + error)
            }
        }
    }, 
    createUser: async (req,res) => {
        try {
            const { FirstName, LastName, Email} = req.body;
            const UserID = req.body.UserID

            const user = await User.findOrCreate({
                where: {
                    UserID
                },
                defaults: {
                UserID,
                FirstName, 
                LastName,
                Email}
            })

            res.locals.User = user

            res.status(201).send(user)

        } catch (error){
            if (error instanceof UniqueConstraintError) {
                res.status(409).send("Unique information already exists in DB")
            }
            else {
                res.status(500).send("In userController.create: " + error)
            }
        }
    },
    getUser: async (req, res, next) =>{
        try {
            const UserID = req.body.id
            const user = await User.findByPk(UserID)

            if (!user) {
                return res.status(404).send({ message: 'User not found' })
            }
            
            res.locals.User = user
            next()

        } catch (error) {
            res.status(500).send(error)
        }
    }   
}

module.exports = userController