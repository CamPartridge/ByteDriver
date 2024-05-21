const sequelize = require('../dbconfig/config.js')
const {DataTypes, Model} = require('sequelize')
const User = require("./user.js")

class UserOrder extends Model { }

//might be unnessisary
sequelize.sync({
    // force: true
})


UserOrder.init({
    OrderID: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    ByterID: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: User,
            key: 'UserID'
        }
    },
    DriverID: {
        type: DataTypes.INTEGER,
        allowNull: false,
        defaultValue: 0,
        references: {
            model: User,
            key: 'UserID'
        }
    },
    Status: {
        type: DataTypes.STRING,
        defaultValue: "Ordered",
        allowNull: false
    }
},
{
    sequelize,
    initialAutoIncrement: 10000,
    timestamps: false
})

module.exports = UserOrder