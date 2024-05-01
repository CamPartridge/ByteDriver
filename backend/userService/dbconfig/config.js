const Sequelize = require("sequelize")

// const sequelize = new Sequelize(
//     'game_api',
//     'root',
//     'password',
//     {
//         host: 'mysql_db',
//         dialect: 'mysql'
//     }
// );

//CAMBRY'S LOCAL MYSQL
const sequelize = new Sequelize(
  '',
  'root',
  'D&D4bookwyrmbam',
   {
     host: 'localhost',
     dialect: 'mysql'
   }
 );

module.exports = sequelize