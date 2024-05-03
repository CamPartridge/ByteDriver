const Sequelize = require("sequelize")

const sequelize = new Sequelize(
    'UserDB',
    'root',
    'slay123!',
    {
        host: 'mysql_userDB',
        dialect: 'mysql'
    }
);

module.exports = sequelize