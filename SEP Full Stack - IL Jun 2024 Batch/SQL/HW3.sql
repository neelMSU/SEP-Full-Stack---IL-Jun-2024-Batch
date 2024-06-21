SELECT DISTINCT E.City
FROM Employees E
INNER JOIN Customers C ON E.City = C.City;

--A
SELECT DISTINCT City
FROM Customers
WHERE City NOT IN (SELECT DISTINCT City FROM Employees);
--B
SELECT DISTINCT C.City
FROM Customers C
LEFT JOIN Employees E ON C.City = E.City
WHERE E.City IS NULL;

SELECT P.ProductName, SUM(OD.Quantity) AS TotalQuantity
FROM Products P
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductName;

SELECT C.City, SUM(OD.Quantity) AS TotalProductsOrdered
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.City;

--A
SELECT City FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID FROM Customers WHERE City = 'CityName'
    UNION ALL
    SELECT CustomerID FROM Customers WHERE City = 'CityName'
)
GROUP BY City
HAVING COUNT(CustomerID) > 1;
--B
SELECT City, COUNT(*) AS NumCustomers
FROM Customers
GROUP BY City
HAVING COUNT(*) >= 2;


SELECT C.City, COUNT(DISTINCT OD.ProductID) AS ProductTypes
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.City
HAVING COUNT(DISTINCT OD.ProductID) >= 2;


SELECT DISTINCT C.CustomerID, C.ContactName
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE C.City <> O.ShipCity;


SELECT TOP 5
    P.ProductName,
    AVG(OD.UnitPrice) AS AveragePrice,
    (
        SELECT TOP 1 C.City
        FROM Customers C
        JOIN Orders O ON C.CustomerID = O.CustomerID
        JOIN [Order Details] OD2 ON O.OrderID = OD2.OrderID
        WHERE OD2.ProductId = OD.ProductId
        GROUP BY C.City
        ORDER BY SUM(OD2.Quantity) DESC
    ) AS TopCity
FROM Products P
JOIN [Order Details] OD ON P.ProductId = OD.ProductId
GROUP BY P.ProductName
ORDER BY SUM(OD.Quantity) DESC;

--A
SELECT DISTINCT E.City
FROM Employees E
WHERE E.City NOT IN (
    SELECT DISTINCT O.ShipCity
    FROM Orders O
);
--B
SELECT DISTINCT E.City
FROM Employees E
LEFT JOIN Orders O ON E.City = O.ShipCity
WHERE O.ShipCity IS NULL;



WITH MostOrders AS (
    SELECT TOP 1 E.City
    FROM Employees E
    JOIN Orders O ON E.EmployeeID = O.EmployeeID
    GROUP BY E.City
    ORDER BY COUNT(*) DESC
),
MostQuantity AS (
    SELECT TOP 1 O.ShipCity
    FROM Orders O
    JOIN [Order Details] OD ON O.OrderID = OD.OrderID
    GROUP BY O.ShipCity
    ORDER BY SUM(OD.Quantity) DESC
)
SELECT 'City with most orders' AS Description, City FROM MostOrders
UNION ALL
SELECT 'City with most quantity' AS Description, ShipCity AS City FROM MostQuantity;


SELECT DISTINCT * FROM TableName;






