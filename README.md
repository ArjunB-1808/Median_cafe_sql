# Median_Cafe_SQL

The Median Cafe - MySQL Database Project
This project involves creating and managing a database for a fictional restaurant, "The Median Cafe." It covers fundamental to advanced MySQL operations, including table creation, data population, and various querying techniques to retrieve and manipulate data.
Scenario.

The Median Cafe is a bustling restaurant that needs a robust system to manage its customer information, bookings, and menu details. This project builds that system from the ground up using MySQL.

Database and Table Setup
1. Create and Use the Database
The first step is to create the The_Median_Cafe database and select it for use.
CREATE DATABASE IF NOT EXISTS The_Median_Cafe;
USE The_Median_Cafe;

2. Create and Populate Tables
Three core tables are created: Customers, Bookings, and Courses.
Customers Table
CREATE TABLE Customers(
    CustomerID INT NOT NULL PRIMARY KEY, 
    FullName VARCHAR(100) NOT NULL, 
    PhoneNumber BIGINT NOT NULL UNIQUE
);

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

Bookings Table
CREATE TABLE Bookings(
    BookingID INT, 
    BookingDate DATE,
    TableNumber INT, 
    NumberOfGuests INT,
    CustomerID INT
); 

INSERT INTO Bookings (BookingID, BookingDate, TableNumber, NumberOfGuests, CustomerID) VALUES
(10, '2021-11-10', 7, 5, 1), (11, '2021-11-10', 5, 2, 2), (12, '2021-11-10', 3, 2, 4),
(13, '2021-11-11', 2, 5, 5), (14, '2021-11-11', 5, 2, 6), (15, '2021-11-11', 3, 2, 7),
(16, '2021-11-11', 3, 5, 1), (17, '2021-11-12', 5, 2, 2), (18, '2021-11-12', 3, 2, 4),
(19, '2021-11-13', 7, 5, 6), (20, '2021-11-14', 5, 2, 3), (21, '2021-11-14', 3, 2, 4);

Courses Table
CREATE TABLE Courses(
    CourseName VARCHAR(255) PRIMARY KEY, 
    Cost Decimal(4,2)
);

INSERT INTO Courses (CourseName, Cost) VALUES 
("Greek salad", 15.50), ("Bean soup", 12.25), ("Pizza", 15.00),
("Carbonara", 12.50), ("Kabasa", 17.00), ("Shwarma", 11.30);

Core Database Tasks
Task 1: Filter data using the WHERE Clause
Create a SQL statement to print all records from the Bookings table for bookings between 2021-11-11 and 2021-11-13.
SELECT * FROM Bookings 
WHERE BookingDate BETWEEN '2021-11-11' AND '2021-11-13';

Expected Output:
+-----------+-------------+-------------+----------------+------------+
| BookingID | BookingDate | TableNumber | NumberOfGuests | CustomerID |
+-----------+-------------+-------------+----------------+------------+
|        13 | 2021-11-11  |           2 |              5 |          5 |
|        14 | 2021-11-11  |           5 |              2 |          6 |
|        15 | 2021-11-11  |           3 |              2 |          7 |
|        16 | 2021-11-11  |           3 |              5 |          1 |
|        17 | 2021-11-12  |           5 |              2 |          2 |
|        18 | 2021-11-12  |           3 |              2 |          4 |
|        19 | 2021-11-13  |           7 |              5 |          6 |
+-----------+-------------+-------------+----------------+------------+

Task 2: Create a JOIN Query
Create a JOIN statement to print customer full names and their booking IDs for the date 2021-11-11.
SELECT Customers.FullName, Bookings.BookingID 
FROM Customers RIGHT JOIN Bookings 
ON Customers.CustomerID = Bookings.CustomerID 
WHERE BookingDate = '2021-11-11';

Expected Output:
+---------------+-----------+
| FullName      | BookingID |
+---------------+-----------+
| Sneha Patel   |        13 |
| Aditya Reddy  |        14 |
| Pooja Rao     |        15 |
| Priya Sharma  |        16 |
+---------------+-----------+

Task 3: Create a GROUP BY Query
Create a SQL statement to print the total number of bookings placed on each date.
SELECT BookingDate, COUNT(BookingDate) 
FROM Bookings 
GROUP BY BookingDate;

Expected Output:
+-------------+--------------------+
| BookingDate | COUNT(BookingDate) |
+-------------+--------------------+
| 2021-11-10  |                  3 |
| 2021-11-11  |                  4 |
| 2021-11-12  |                  2 |
| 2021-11-13  |                  1 |
| 2021-11-14  |                  2 |
+-------------+--------------------+

Task 4: Create a REPLACE Statement
Update the cost of the "Kabasa" course to $20.00.
REPLACE INTO Courses (CourseName, Cost) VALUES ("Kabasa", 20.00);
SELECT * FROM Courses;

Expected Output:
+-------------+-------+
| CourseName  | Cost  |
+-------------+-------+
| Bean soup   | 12.25 |
| Carbonara   | 12.50 |
| Greek salad | 15.50 |
| Kabasa      | 20.00 |
| Pizza       | 15.00 |
| Shwarma     | 11.30 |
+-------------+-------+

Task 5: Create Constraints
Create a new DeliveryAddress table with a FOREIGN KEY constraint.
CREATE TABLE DeliveryAddress(     
    ID INT PRIMARY KEY,     
    Address VARCHAR(255) NOT NULL,     
    Type VARCHAR(100) NOT NULL DEFAULT "Private",     
    CustomerID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
SHOW COLUMNS FROM DeliveryAddress;

Expected Output:
+------------+--------------+------+-----+---------+-------+
| Field      | Type         | Null | Key | Default | Extra |
+------------+--------------+------+-----+---------+-------+
| ID         | int          | NO   | PRI | NULL    |       |
| Address    | varchar(255) | NO   |     | NULL    |       |
| Type       | varchar(100) | NO   |     | Private |       |
| CustomerID | int          | NO   | MUL | NULL    |       |
+------------+--------------+------+-----+---------+-------+

Task 6: Alter Table Structure
Add a new Ingredients column to the Courses table.
ALTER TABLE Courses ADD COLUMN Ingredients VARCHAR(255);
SHOW COLUMNS FROM Courses;

Expected Output:
+-------------+---------------+------+-----+---------+-------+
| Field       | Type          | Null | Key | Default | Extra |
+-------------+---------------+------+-----+---------+-------+
| CourseName  | varchar(255)  | NO   | PRI | NULL    |       |
| Cost        | decimal(4,2)  | YES  |     | NULL    |       |
| Ingredients | varchar(255)  | YES  |     | NULL    |       |
+-------------+---------------+------+-----+---------+-------+

Task 7: Create a Subquery
Print the full names of all customers who made bookings on 2021-11-11.
SELECT FullName 
FROM Customers 
WHERE CustomerID IN (SELECT CustomerID FROM Bookings WHERE BookingDate = '2021-11-11');

Expected Output:
+---------------+
| FullName      |
+---------------+
| Priya Sharma  |
| Sneha Patel   |
| Aditya Reddy  |
| Pooja Rao     |
+---------------+

Task 8: Create a Virtual Table (VIEW)
Create a BookingsView virtual table to print bookings with more than 3 guests made before 2021-11-13.
CREATE VIEW BookingsView AS 
SELECT BookingID, BookingDate, NumberOfGuests 
FROM Bookings 
WHERE NumberOfGuests > 3 AND BookingDate < "2021-11-13";

SELECT * FROM BookingsView;

Expected Output:
+-----------+-------------+----------------+
| BookingID | BookingDate | NumberOfGuests |
+-----------+-------------+----------------+
|        10 | 2021-11-10  |              5 |
|        13 | 2021-11-11  |              5 |
|        16 | 2021-11-11  |              5 |
+-----------+-------------+----------------+

Task 9: Create a Stored Procedure
Create a stored procedure GetBookingsData to retrieve bookings based on a date parameter.
DELIMITER //
CREATE PROCEDURE GetBookingsData (InputDate DATE)
BEGIN
    SELECT * FROM Bookings 
    WHERE BookingDate = InputDate;
END //
DELIMITER ;

CALL GetBookingsData("2021-11-13");

Expected Output:
+-----------+-------------+-------------+----------------+------------+
| BookingID | BookingDate | TableNumber | NumberOfGuests | CustomerID |
+-----------+-------------+-------------+----------------+------------+
|        19 | 2021-11-13  |           7 |              5 |          6 |
+-----------+-------------+-------------+----------------+------------+

Task 10: Use a String Function
Use CONCAT to list booking details in a formatted string.
SELECT CONCAT("ID: ", BookingID,', Date: ', BookingDate,', Number of guests: ', NumberOfGuests) AS "Booking Details" 
FROM Bookings;

Expected Output:
+----------------------------------------------------------+
| Booking Details                                          |
+----------------------------------------------------------+
| ID: 10, Date: 2021-11-10, Number of guests: 5             |
| ID: 11, Date: 2021-11-10, Number of guests: 2             |
| ID: 12, Date: 2021-11-10, Number of guests: 2             |
| ID: 13, Date: 2021-11-11, Number of guests: 5             |
| ID: 14, Date: 2021-11-11, Number of guests: 2             |
| ID: 15, Date: 2021-11-11, Number of guests: 2             |
| ID: 16, Date: 2021-11-11, Number of guests: 5             |
| ID: 17, Date: 2021-11-12, Number of guests: 2             |
| ID: 18, Date: 2021-11-12, Number of guests: 2             |
| ID: 19, Date: 2021-11-13, Number of guests: 5             |
| ID: 20, Date: 2021-11-14, Number of guests: 2             |
| ID: 21, Date: 2021-11-14, Number of guests: 2             |
+----------------------------------------------------------+

--Project finished by----
Vamsi (GitHub username : VamsKrishB ) and Arjun (Github username : ArjunB-1808)
