const { UniqueConstraintError } = require('sequelize')
const  User = require("../models/user")
var { sendEmail } = require("../producer.js")

const userController = {
    create: async (req, res) => {
        try {
            const { FirstName, LastName, Password, PhoneNumber, Email, Type } = req.body;

            const user = await User.create({
                FirstName,
                LastName,
                Password,
                PhoneNumber,
                Email,
                Type
            })

            sendEmail('Users', 'newUser', JSON.stringify(user.dataValues))

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
    read: async (req, res) => {
        try {
            const users = await User.findAll()
            res.status(200).send(users)
        } catch (error) {
            res.status(500).send("In userController.read: " + error)
        }
    },
    readByPhoneNumber: async (req, res, next) => {
        try {
            const PhoneNumber = req.body.PhoneNumber
            const user = await User.findAll({
                where: {
                    PhoneNumber
                }
            })

            if(!user) {
                return res.status(404).send({message: 'No User found'})
            }

            res.locals.User = user
            next();
        } catch (error) {
            res.status(500).send("In userController.readByType: " + error)
        }
    },
    readByType: async (req, res) => {
        try {
            const Type = req.params.type
            const users = await User.findAll({
                where: {
                    Type
                }
            })

            if(!users) {
                return res.status(404).send({message: 'No Users found'})
            }
            res.status(200).send(users)
        } catch (error) {
            res.status(500).send("In userController.readByType: " + error)
        }
    },
    readByID: async (req, res) => {
        try {
            const UserId = req.params.userid
            const user = await User.findByPk(UserId)

            if(!user) {
                return res.status(404).send({message: 'No User found'})
            }
            res.status(200).send(user)
        } catch (error) {
            res.status(500).send("In userController.readByID: " + error)
        }
    }, 
    deleteUser: async (req, res) => {
        try {
            const UserId = req.params.userid
            const user = await User.findByPk(UserId)

            if (!user) {
                return res.status(404).send({ message: 'User not found' })
            }

            await user.destroy()

            res.status(200).send()
        } catch (error) {
            res.status(500).send("In userController.deleteUser: " + error)
        }
    },
    updateUser: async (req, res) => {
        try {
            const UserId = req.params.userid
            const user = await User.findByPk(UserId)

            if (!user) {
                return res.status(404).send({ message: 'User not found' })
            }

            const updates = {}
            updates.FirstName = req.body.UserName
            updates.LastName = req.body.LastName
            updates.Password = req.body.Password
            updates.PhoneNumber = req.body.PhoneNumber
            updates.Email = req.body.Email
            updates.Type = req.body.Type

            await user.update(updates)

            res.status(200).send(user)
        } catch (error) {
            res.status(500).send("In userController.updateUser: " + error)
        }
    },
    updateUserType: async (req,res) => {
        try {
            const UserId = req.params.userid
            const user = await User.findByPk(UserId)
            
            if (!user) {
                return res.status(404).send({ message: 'User not found' })
            }
            
            const updates = {}
            updates.Type = req.params.type

            await user.update(updates)

            res.status(200).send(user)
        } catch (error) {
            res.status(500).send("In userController.updateUserType: " + error)
        }
    }

}

module.exports = userController