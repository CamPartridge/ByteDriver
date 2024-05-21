const { UniqueConstraintError } = require('sequelize')
const  Order = require("../models/order.js")
var { sendEmail } = require("../producer.js")

const orderController = {
    test: (req, res) => {
        res.send("Test Success")
    },
    create:  async (req, res) => {
        try {

            const menuItems = req.body.menuItems 
            const OrderID = res.locals.UserOrder.OrderID


            for (const item of menuItems) {
                ItemName = item.name
                ItemPrice = item.price
                Quantity = item.quantity

                await Order.create({
                    OrderID,
                    ItemName,
                    ItemPrice,
                    Quantity
                })
            }

            const FirstName = res.locals.User[0].FirstName
            const LastName = res.locals.User[0].LastName
            const OrderNumber = OrderID

            info = {
                FirstName,
                LastName,
                OrderNumber,
                menuItems
            }

            res.status(201).send(info)

        } catch (error){
            if (error instanceof UniqueConstraintError) {
                res.status(409).send("Unique information already exists in DB")
            }
            else {
                res.status(500).send("In orderController.create: " + error)
            }
        }
    }, 
    findAllByOrderID: async (req,res) => {
        try {
            const OrderID = req.params.id
            const orders = await Order.findAll({
                where: {OrderID}
            })
            res.status(200).send(orders)
        } catch (error){
            if (error instanceof UniqueConstraintError) {
                res.status(409).send("Unique information already exists in DB")
            }
            else {
                res.status(500).send("In orderController.create: " + error)
            }
        }
    },
    findAndGroupByOrderIDs: async (req, res) => {
        try {
            const orderIDs = res.locals.orderIDs;

            const orders = await Order.findAll({
                where: {
                    OrderID: orderIDs
                }
            });

            res.status(200).send(orders);

        } catch (error) {
            if (error instanceof UniqueConstraintError) {
                res.status(409).send("Unique information already exists in DB");
            } else {
                res.status(500).send("In orderController.findAllByOrderIDs: " + error);
            }
        }
    }
}

module.exports = orderController