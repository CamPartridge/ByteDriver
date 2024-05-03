const Sequelize = require("sequelize")

// const sequelize = new Sequelize(
//     'UserDB',
//     'root',
//     'slay123!',
//     {
//         host: 'mysql_userDB',
//         dialect: 'mysql'
//     }
// );

const sequelize = new Sequelize(
  'userdb',
  'root',
  'D&D4bookwyrmbam',
   {
     host: 'localhost',
     dialect: 'mysql'
   }
 );

module.exports = sequelize