-- 1. List all countries in South America.
SELECT Name FROM country WHERE Continent = "South America"
  
-- 2. Find the population of 'Germany'.
SELECT Population from country WHERE Name = "Germany";

-- 3. Retrieve all cities in the country 'Japan'.
SELECT Name FROM city WHERE CountryCode = (SELECT Code FROM country WHERE Name = "Japan");

-- 4. Find the 3 most populated countries in the 'Africa' region.
SELECT Name FROM country WHERE region = "Western Africa" ORDER BY Population DESC LIMIT 3;

-- 5. Retrieve the country and its life expectancy where the population is between 1 and 5 million.
SELECT Name, LifeExpectancy FROM country WHERE population > 1 AND population < 5000000;

-- 6. List countries with an official language of 'French'.
SELECT Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language = "French" AND countrylanguage.IsOfficial = "T";

-- 7. Retrieve all album titles by the artist 'AC/DC'.
SELECT Title FROM Album JOIN Artist ON Album.ArtistId = Artist.ArtistId WHERE Artist.Name = "AC/DC";

-- 8. Find the name and email of customers located in 'Brazil'.
SELECT FirstName, LastName, Email FROM Customer WHERE Country = "Brazil";

-- 9. List all playlists in the database.
SELECT Name FROM Playlist;

-- 10. Find the total number of tracks in the 'Rock' genre.
SELECT COUNT(Track.Name) FROM Track JOIN Genre ON Track.GenreId = Genre.GenreId WHERE Genre.Name = "Rock";

-- 11. List all employees who report to 'Nancy Edwards'.
SELECT FirstName, LastName FROM Employee WHERE ReportsTo = (SELECT EmployeeId FROM Employee WHERE FirstName = "Nancy" AND LastName = "Edwards");

-- 12. Calculate the total sales per customer by summing the total amount in invoices.
SELECT Customer.FirstName,Customer.LastName,  SUM(Invoice.Total) AS CustomerTotal FROM Customer JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId GROUP BY Customer.CustomerId;


-- **Design Your Database:** Create a database for a small business of your choice, with at least 3 tables with appropriate columns.
-- **Create the Tables:** Write SQL statements to create the tables for your database. Ensure that each table has a primary key and relationships where appropriate.
CREATE TABLE Catalog (FlowerID INT PRIMARY KEY AUTO_INCREMENT, FlowerName VARCHAR(50) NOT NULL, Category VARCHAR(50), Price DECIMAL(4, 2) NOT NULL);
CREATE TABLE Customers (CustomerID INT PRIMARY KEY AUTO_INCREMENT, Name VARCHAR(50) NOT NULL, PhoneNumber VARCHAR(10) NOT NULL, Email VARCHAR(254));
CREATE TABLE Orders (OrderID INT PRIMARY KEY AUTO_INCREMENT, CustomerID INT, TotalAmount DECIMAL(8, 2), FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID));
CREATE TABLE OrderList ( OrderListID INT PRIMARY KEY AUTO_INCREMENT, OrderID INT, FlowerID INT, Quantity INT NOT NULL, FOREIGN KEY (OrderID) REFERENCES Orders(OrderID), FOREIGN KEY (FlowerID) REFERENCES Catalog(FlowerID));

-- **Insert Data:** Insert at least 5 rows of data into each of the tables you created.
INSERT INTO Catalog (FlowerName, Category, Price) VALUES
('English Shrub Rose', 'Rose', 35.00),
('Maximilian Sunflower', 'Sunflower', 40.00),
('Climbing Rose', 'Rose', 60.00),
('Triumph Tulip', 'Tulip', 13.50),
('Moutan Peony', 'Peony', 15.00);

INSERT INTO Customers (Name, PhoneNumber, Email) VALUES
('Gary Jones', '8133169487', 'garr123@gmail.com'),
('Liza Samules', '7089800823', 'samulesl@yahoo.com'),
('Hannah Robbins', '6090403257', 'hannah.rob@gmail.com'),
('Jake Lake', '8932357787', 'jake.lake@gmail.com'),
('Fred Borris', '9029197092', 'borris5678@gmail.com');

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES 
(1, 50.50),
(2, 70.00),
(3, 100.50),
(4, 30.50),
(5, 120.00);

INSERT INTO OrderList (OrderID, FlowerID, Quantity)VALUES 
(1, 1, 4),
(2, 3, 2),
(3, 2, 3),
(4, 4, 10),
(5, 5, 2);

-- Shows all the names and total order amounts for each customer.
SELECT Orders.OrderID, Customers.Name AS CustomerName, Orders.TotalAmount FROM Orders JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- Shows the total quntity for each flower sold
SELECT Catalog.FlowerName, SUM(OrderList.Quantity) AS TotalSold FROM OrderList JOIN Catalog ON OrderList.FlowerID = Catalog.FlowerID GROUP BY Catalog.FlowerName;

-- Shows the top 3 highest spending customers
SELECT Customers.Name AS CustomerName, SUM(Orders.TotalAmount) AS TotalSpent FROM Orders JOIN Customers ON Orders.CustomerID = Customers.CustomerID GROUP BY Customers.CustomerID ORDER BY TotalSpent DESC LIMIT 3;
