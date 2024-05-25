var express = require('express');
var router = express.Router();

const authController = require("../controllers/authController")
const userController = require("../controllers/userController.js")

router.get("/", userController.read)

router.post("/", authController.register, userController.create)

router.get("/test", userController.test)

router.post("/login", userController.readByEmail, authController.login)

router.get("/findType/:type", userController.readByType)

router.get("/:userid(\\d+)", userController.readByID)

router.put("/:userid(\\d+)", userController.updateUser)

router.delete("/:userid(\\d+)", userController.deleteUser)

router.patch("/:userid(\\d+)/changetype/:type", userController.updateUserType)

module.exports = router;
