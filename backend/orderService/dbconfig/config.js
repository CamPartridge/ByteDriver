const Sequelize = require("sequelize")

const sequelize = new Sequelize(
    'OrderDB',
    'root',
    'slay123!',
    {
        host: 'mysql_orderDB',
        dialect: 'mysql'
    }
);


// const sequelize = new Sequelize(
//   'OrderDB',
//   'root',
//   'D&D4bookwyrmbam',
//    {
//      host: 'localhost',
//      dialect: 'mysql'
//    }
//  );

module.exports = sequelize