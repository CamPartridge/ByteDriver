CREATE DATABASE OrderDB;

USE OrderDB;

CREATE TABLE users(
    userid INT NOT NULL,
    phone_number BIGINT NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (UserID)
);

CREATE TABLE user_orders(
    orderid INT NOT NULL AUTO_INCREMENT,
    byterid INT NOT NULL,
    driverid INT NULL,
    Status VARCHAR(20) NOT NULL,
    -- FOREIGN KEY (byterid) REFERENCES users(userid),
    -- FOREIGN KEY (driverid) REFERENCES users(userid),
    PRIMARY KEY (orderid)
)AUTO_INCREMENT=10000;

CREATE TABLE orders(
    id INT NOT NULL AUTO_INCREMENT,
    orderid INT NOT NULL,
    item_name VARCHAR(50) NOT NULL,
    item_price DECIMAL(19,4) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (id)
    -- FOREIGN KEY (orderid) REFERENCES user_orders(orderid)
) AUTO_INCREMENT=100


