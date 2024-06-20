SELECT COUNT(*) AS TotalProducts
FROM Production.Product;

SELECT COUNT(*) AS ProductsInSubcategories
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL;

SELECT 
    ProductSubcategoryID,
    COUNT(*) AS CountedProducts
FROM 
    Production.Product
WHERE 
    ProductSubcategoryID IS NOT NULL
GROUP BY 
    ProductSubcategoryID
ORDER BY 
    ProductSubcategoryID;


SELECT COUNT(*) AS ProductsWithoutSubcategory
FROM Production.Product
WHERE ProductSubcategoryID IS NULL;

SELECT SUM(Quantity) AS TotalProductQuantity
FROM Production.ProductInventory;


SELECT 
    ProductID,
    SUM(Quantity) AS TheSum
FROM 
    Production.ProductInventory
WHERE 
    LocationID = 40
GROUP BY 
    ProductID
HAVING 
    SUM(Quantity) < 100;


SELECT 
    Shelf,
    ProductID,
    SUM(Quantity) AS TheSum
FROM 
    Production.ProductInventory
WHERE 
    LocationID = 40
GROUP BY 
    Shelf, ProductID
HAVING 
    SUM(Quantity) < 100;


SELECT AVG(Quantity) AS AverageQuantity
FROM Production.ProductInventory
WHERE LocationID = 10;

SELECT 
    ProductID, 
    Shelf, 
    AVG(Quantity) AS TheAvg
FROM 
    Production.ProductInventory
GROUP BY 
    ProductID, Shelf
ORDER BY 
    ProductID, Shelf;

SELECT 
    ProductID, 
    Shelf, 
    AVG(Quantity) AS TheAvg
FROM 
    Production.ProductInventory
WHERE 
    Shelf <> 'N/A'  -- Excludes rows where Shelf is 'N/A'
GROUP BY 
    ProductID, Shelf
ORDER BY 
    ProductID, Shelf;

SELECT 
    Color, 
    Class, 
    COUNT(*) AS TheCount, 
    AVG(ListPrice) AS AvgPrice
FROM 
    Production.Product
WHERE 
    Color IS NOT NULL AND Class IS NOT NULL
GROUP BY 
    Color, Class
ORDER BY 
    Color, Class;


SELECT 
    cr.Name AS Country, 
    sp.Name AS Province
FROM 
    Person.CountryRegion AS cr
JOIN 
    Person.StateProvince AS sp
    ON cr.CountryRegionCode = sp.CountryRegionCode
ORDER BY 
    cr.Name, sp.Name;


SELECT 
    cr.Name AS Country, 
    sp.Name AS Province
FROM 
    Person.CountryRegion AS cr
JOIN 
    Person.StateProvince AS sp
    ON cr.CountryRegionCode = sp.CountryRegionCode
WHERE 
    cr.Name IN ('Germany', 'Canada')
ORDER BY 
    cr.Name, sp.Name;

--Northwind

SELECT DISTINCT 
    p.ProductID, 
    p.ProductName
FROM 
    Products p
JOIN 
    [Order Details] od ON p.ProductID = od.ProductID
JOIN 
    Orders o ON od.OrderID = o.OrderID
WHERE 
    o.OrderDate >= DATEADD(year, -27, GETDATE())
ORDER BY 
    p.ProductName;

SELECT TOP 5 ShipPostalCode AS ZipCode, COUNT(*) AS TotalOrders
FROM Orders
GROUP BY ShipPostalCode
ORDER BY TotalOrders DESC;


SELECT TOP 5 ShipPostalCode AS ZipCode, COUNT(*) AS TotalOrders
FROM Orders
WHERE OrderDate >= DATEADD(year, -27, GETDATE())
GROUP BY ShipPostalCode
ORDER BY TotalOrders DESC;

SELECT City, COUNT(*) AS NumberOfCustomers
FROM Customers
GROUP BY City
ORDER BY City;

SELECT City, COUNT(*) AS NumberOfCustomers
FROM Customers
GROUP BY City
HAVING COUNT(*) > 2;

SELECT DISTINCT c.ContactName, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate > '1998-01-01'
ORDER BY o.OrderDate DESC;

SELECT c.ContactName, MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName
ORDER BY MostRecentOrderDate DESC;

SELECT c.ContactName, SUM(od.Quantity) AS TotalProducts
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.ContactName
ORDER BY TotalProducts DESC;

SELECT c.CustomerID, SUM(od.Quantity) AS TotalProducts
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID
HAVING SUM(od.Quantity) > 100;

SELECT DISTINCT 
    s.CompanyName AS SupplierCompanyName, 
    sh.CompanyName AS ShippingCompanyName
FROM Suppliers s
CROSS JOIN Shippers sh;

SELECT o.OrderDate, p.ProductName
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
ORDER BY o.OrderDate, p.ProductName;

SELECT e1.EmployeeID, e1.FirstName + ' ' + e1.LastName AS Employee1, 
       e2.EmployeeID, e2.FirstName + ' ' + e2.LastName AS Employee2, 
       e1.Title
FROM Employees e1
JOIN Employees e2 ON e1.Title = e2.Title AND e1.EmployeeID < e2.EmployeeID
ORDER BY e1.Title;

SELECT m.EmployeeID, m.FirstName + ' ' + m.LastName AS Manager, COUNT(e.EmployeeID) AS Reportees
FROM Employees m
JOIN Employees e ON m.EmployeeID = e.ReportsTo
GROUP BY m.EmployeeID, m.FirstName, m.LastName
HAVING COUNT(e.EmployeeID) > 2;

SELECT 
    City, 
    'Customer' AS EntityType, 
    ContactName AS EntityName
FROM Customers
UNION ALL
SELECT 
    City, 
    'Supplier' AS EntityType, 
    ContactName AS EntityName
FROM Suppliers
ORDER BY City, EntityType, EntityName;













