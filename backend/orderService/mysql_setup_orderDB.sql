CREATE DATABASE OrderDB;

USE OrderDB;

CREATE TABLE Users(
    UserID INT NOT NULL,
    Email VARCHAR(50) NOT NULL UNIQUE,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PRIMARY KEY (UserID)
);

CREATE TABLE UserOrders(
    OrderID INT NOT NULL AUTO_INCREMENT,
    ByterID INT NOT NULL,
    DriverID INT NULL,
    Status VARCHAR(20) NOT NULL,
    -- FOREIGN KEY (byterid) REFERENCES users(userid),
    -- FOREIGN KEY (driverid) REFERENCES users(userid),
    PRIMARY KEY (orderid)
)AUTO_INCREMENT=10000;

CREATE TABLE Orders(
    ID INT NOT NULL AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ItemName VARCHAR(50) NOT NULL,
    ItemPrice DECIMAL(19,4) NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (ID)
) AUTO_INCREMENT=100;

use OrderDB;
INSERT INTO Users (UserID, Email, FirstName, LastName)
VALUES (0, 'none', 'none', 'none');


