SELECT Name FROM country WHERE Continent = "South America";

SELECT Population from country WHERE Name = "Germany";

SELECT Name FROM city WHERE CountryCode = (SELECT Code FROM country WHERE Name = "Japan");

SELECT Name FROM country WHERE region = "Western Africa" ORDER BY Population DESC LIMIT 3;

SELECT Name, LifeExpectancy FROM country WHERE population > 1 AND population < 5000000;

SELECT Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language = "French" AND countrylanguage.IsOfficial = "T";

SELECT Title FROM Album JOIN Artist ON Album.ArtistId = Artist.ArtistId WHERE Artist.Name = "AC/DC";

SELECT FirstName, LastName, Email FROM Customer WHERE Country = "Brazil";

SELECT Name FROM Playlist;

SELECT COUNT(Track.Name) FROM Track JOIN Genre ON Track.GenreId = Genre.GenreId WHERE Genre.Name = "Rock";

SELECT FirstName, LastName FROM Employee WHERE ReportsTo = (SELECT EmployeeId FROM Employee WHERE FirstName = "Nancy" AND LastName = "Edwards");

SELECT Customer.FirstName,Customer.LastName,  SUM(Invoice.Total) AS CustomerTotal FROM Customer JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId GROUP BY Customer.CustomerId;
