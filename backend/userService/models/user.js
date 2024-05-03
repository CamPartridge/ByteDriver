const sequelize = require('../dbconfig/config.js')
const {DataTypes, Model} = require('sequelize')

class User extends Model { }

//might be unnessisary
sequelize.sync({
    // force: true
})

User.init({
    UserID: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    FirstName: {
        type: DataTypes.STRING,
        allowNull: false
    }, 
    LastName: {
        type: DataTypes.STRING,
        allowNull: false
    },
    Password: {
        type: DataTypes.STRING,
        allowNull: false
    },
    PhoneNumber: {
        type: DataTypes.INTEGER,
        unique: true,
        allowNull: false
    },
    Email: {
        type: DataTypes.STRING,
        unique: true,
        allowNull: false
    },
    Type: {
        type: DataTypes.STRING,
        allowNull: false
    }
},
{
    sequelize,
    initialAutoIncrement: 1000,
    timestamps: false
})

module.exports = User