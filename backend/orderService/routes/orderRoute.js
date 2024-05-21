var express = require('express');
var router = express.Router();

const userController = require("../controllers/userController.js")
const orderController = require("../controllers/orderController.js")
const userorderController = require("../controllers/userordersController.js")

router.post("/", userController.create, userorderController.create, orderController.create)
router.get("/order/test", orderController.test)
router.post("/adduser", userController.createUser)

router.get('/:id(\\d+)', orderController.findAllByOrderID)
router.get('/status/:status', userorderController.findAllByStatus, orderController.findAndGroupByOrderIDs)

router.patch("/:id(\\d+)/:status", userorderController.updateStatus)
router.patch("/:id(\\d+)", userController.create, userorderController.updateDriver)

//Test route
//get all route

module.exports = router;