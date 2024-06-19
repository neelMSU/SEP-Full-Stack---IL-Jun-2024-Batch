SELECT ProductID, ProductName, UnitPrice
FROM Products;

SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > 0;

SELECT ProductID, ProductName, QuantityPerUnit AS Color, UnitPrice
FROM Products
WHERE QuantityPerUnit IS NULL;

SELECT ProductID, ProductName, QuantityPerUnit AS Color, UnitPrice
FROM Products
WHERE QuantityPerUnit IS NOT NULL;

SELECT ProductID, ProductName, QuantityPerUnit AS Color, UnitPrice
FROM Products
WHERE QuantityPerUnit IS NOT NULL AND UnitPrice > 0;

SELECT CONCAT(ProductName, ' ', QuantityPerUnit) AS ProductAndColor
FROM Products
WHERE QuantityPerUnit IS NOT NULL;

SELECT 
    'ProductName: ' + ProductName AS ProductDescription
FROM 
    Products
WHERE 
    ProductName IN ('Chef Anton''s Cajun Seasoning', 'Chef Anton''s Gumbo Mix', 'Grandma''s Boysenberry Spread')
ORDER BY 
    ProductName;



SELECT ProductID, ProductName
FROM Products
WHERE ProductID BETWEEN 400 AND 500;

--Northwind does not have a Color column; thus this type of query isn't applicable.

SELECT *
FROM Products
WHERE ProductName LIKE 'S%';


SELECT 
    ProductName,
    FORMAT(UnitPrice, 'N2', 'en-US') AS UnitPrice
FROM 
    Products
ORDER BY 
    ProductName;

SELECT 
    ProductName,
    FORMAT(UnitPrice, 'N2', 'de-DE') AS UnitPrice  -- Using German locale for comma as decimal separator
FROM 
    Products
WHERE 
    ProductName LIKE 'A%' OR ProductName LIKE 'S%'
ORDER BY 
    ProductName;


SELECT *
FROM Products
WHERE ProductName LIKE 'SPO%' AND ProductName NOT LIKE 'SPOK%'
ORDER BY ProductName;

SELECT DISTINCT QuantityPerUnit
FROM Products
WHERE QuantityPerUnit IS NOT NULL
ORDER BY QuantityPerUnit DESC;

SELECT DISTINCT CategoryID, QuantityPerUnit
FROM Products
WHERE CategoryID IS NOT NULL AND QuantityPerUnit IS NOT NULL
ORDER BY CategoryID, QuantityPerUnit;


