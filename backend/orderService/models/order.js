const sequelize = require('../dbconfig/config.js')
const {DataTypes, Model} = require('sequelize')
const UserOrders = require('./userorders.js')

class Order extends Model { }

//might be unnessisary
sequelize.sync({
    // force: true
})

Order.init({
    ID: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    OrderID: {
        type: DataTypes.INTEGER,
        allowNull: false,    
        references: {
            model: UserOrders,
            key: 'OrderID'
        }
    }, 
    ItemName: {
        type: DataTypes.STRING,
        allowNull: false
    },
    ItemPrice: {
        type: DataTypes.DECIMAL,
        allowNull: false
    },
    Quantity: {
        type: DataTypes.INTEGER,
        allowNull: false
    }
},
{
    sequelize,
    initialAutoIncrement: 100,
    timestamps: false
})

module.exports = Order