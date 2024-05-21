const { UniqueConstraintError } = require('sequelize')
const  UserOrder = require("../models/userorders.js")
var { sendEmail } = require("../producer.js")

const userorderController = {
    create:  async (req, res, next) => {
        try {  
            const ByterID = res.locals.User[0].UserID

            const userOrder = await UserOrder.create({
               ByterID
            })

            res.locals.UserOrder = userOrder
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
    updateStatus: async (req,res) => {
        try{
            const OrderID = req.params.id
            const Status = req.params.status

            const userOrder = await UserOrder.findByPk(OrderID)

            if(!userOrder){
                res.status(404).send("No order found")
            }

            await userOrder.update({Status})

            res.status(200).send(userOrder)

        }catch (error){
            res.status(500).send("In userorderController.updateStatus: " + error)
        }
    },
    updateDriver: async (req,res) => {
        try{
            const OrderID = req.params.id
            const DriverID = req.body.UserID

            const userOrder = await UserOrder.findByPk(OrderID)

            if(!userOrder){
                res.status(404).send("No order found")
            }

            await userOrder.update({DriverID})

            res.status(200).send(userOrder)

        }catch (error){
            res.status(500).send("In userorderController.updateDriver: " + error)
        }
    },
    findAllByStatus: async (req, res, next) => {
        try {
            const status = req.params.status;
            const userOrders = await UserOrder.findAll({
                where: { Status: status }
            });

            if (!userOrders.length) {
                return res.status(404).send("No orders found with the specified status");
            }

            const orderIDs = userOrders.map(order => order.OrderID);
            res.locals.orderIDs = orderIDs;
            next();

        } catch (error) {
            res.status(500).send("In userorderController.findAllByStatus: " + error);
        }
    },
}

module.exports = userorderController