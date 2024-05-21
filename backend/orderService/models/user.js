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
        primaryKey: true
    },
    FirstName: {
        type: DataTypes.STRING,
        allowNull: false
    }, 
    LastName: {
        type: DataTypes.STRING,
        allowNull: false
    },
    Email: {
        type: DataTypes.STRING,
        unique: true,
        allowNull: false
    }
},
{
    sequelize,
    timestamps: false
})

module.exports = User