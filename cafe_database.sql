CREATE DATABASE IF NOT EXISTS The_Median_Cafe;

SHOW DATABASES;

USE The_Median_Cafe;

CREATE TABLE Customers(CustomerID INT NOT NULL PRIMARY KEY, FullName VARCHAR(100) NOT NULL, PhoneNumber BIGINT NOT NULL UNIQUE);

SHOW TABLES;

INSERT INTO Customers(CustomerID, FullName, PhoneNumber) VALUES 
(1, "Priya Sharma", 9876543210), 
(2, "Rohan Gupta", 9876543211), 
(3, "Anjali Singh", 9876543212), 
(4, "Vikram Kumar", 9876543213), 
(5, "Sneha Patel", 9876543214),      
(6, "Aditya Reddy", 9876543215),      
(7, "Pooja Rao", 9876543216),      
(8, "Arjun Nair", 9876543217),      
(9, "Kavita Joshi", 9876543218),     
(10, "Sameer Desai", 9876543219);

SELECT * FROM Customers;

CREATE TABLE Bookings(BookingID INT, BookingDate DATE,TableNumber INT, NumberOfGuests INT,CustomerID INT); 

INSERT INTO Bookings 
(BookingID, BookingDate, TableNumber, NumberOfGuests, CustomerID) 
VALUES
(10, '2021-11-10', 7, 5, 1),  
(11, '2021-11-10', 5, 2, 2),  
(12, '2021-11-10', 3, 2, 4), 
(13, '2021-11-11', 2, 5, 5),  
(14, '2021-11-11', 5, 2, 6),  
(15, '2021-11-11', 3, 2, 7), 
(16, '2021-11-11', 3, 5, 1),  
(17, '2021-11-12', 5, 2, 2),  
(18, '2021-11-12', 3, 2, 4), 
(19, '2021-11-13', 7, 5, 6),  
(20, '2021-11-14', 5, 2, 3),  
(21, '2021-11-14', 3, 2, 4);

SELECT * FROM Bookings;

CREATE TABLE Courses(CourseName VARCHAR(255) PRIMARY KEY, Cost Decimal(4,2));

INSERT INTO Courses (CourseName, Cost) VALUES 
("Greek salad", 15.50), 
("Bean soup", 12.25), 
("Pizza", 15.00), 
("Carbonara", 12.50), 
("Kabasa", 17.00), 
("Shwarma", 11.30);

SELECT * FROM Courses;

SHOW TABLES;

SELECT * FROM Bookings 
WHERE BookingDate BETWEEN '2021-11-11' AND '2021-11-13';

SELECT Customers.FullName, Bookings.BookingID 
FROM Customers RIGHT JOIN Bookings 
ON Customers.CustomerID = Bookings.CustomerID 
WHERE BookingDate = '2021-11-11';

SELECT BookingDate, COUNT(BookingDate) 
FROM Bookings 
GROUP BY BookingDate;

REPLACE INTO Courses (CourseName, Cost) VALUES ("Kabasa", 20.00);
SELECT * FROM Courses;

CREATE TABLE DeliveryAddress(     
    ID INT PRIMARY KEY,     
    Address VARCHAR(255) NOT NULL,     
    Type VARCHAR(100) NOT NULL DEFAULT "Private",     
    CustomerID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
SHOW COLUMNS FROM DeliveryAddress;

ALTER TABLE Courses ADD COLUMN Ingredients VARCHAR(255);
SHOW COLUMNS FROM Courses;

SELECT FullName 
FROM Customers 
WHERE CustomerID IN (SELECT CustomerID FROM Bookings WHERE BookingDate = '2021-11-11');

CREATE VIEW BookingsView AS SELECT BookingID, BookingDate, NumberOfGuests FROM Bookings WHERE NumberOfGuests > 3 AND BookingDate < "2021-11-13";
SELECT * FROM BookingsView;

DELIMITER //
CREATE PROCEDURE GetBookingsData (InputDate DATE)
BEGIN
    SELECT * FROM Bookings 
    WHERE BookingDate = InputDate;
END //
DELIMITER ;

CALL GetBookingsData("2021-11-13");

SELECT CONCAT("ID: ", BookingID,', Date: ', BookingDate,', Number of guests: ', NumberOfGuests) AS "Booking Details" FROM Bookings;
