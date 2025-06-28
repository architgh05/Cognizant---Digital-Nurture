-- 1. Drop the table if it already exists
DROP TABLE IF EXISTS Products_new;

-- 2. Create the Products_new table
CREATE TABLE Products_new (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- 3. Insert sample data
INSERT INTO Products_new (ProductID, ProductName, Category, Price) VALUES
(1, 'Laptop',       'Electronics', 1200),
(2, 'Smartphone',   'Electronics', 1000),
(3, 'Headphones',   'Electronics', 300),
(4, 'Blender',      'Kitchen',     150),
(5, 'Microwave',    'Kitchen',     200),
(6, 'Toaster',      'Kitchen',     150),
(7, 'Monitor',      'Electronics', 300);

-- 4. View the entire table
SELECT * FROM Products_new;

-- 5. Use ROW_NUMBER() to get top 3 per category (unique ranks)
PRINT '--- Top 3 using ROW_NUMBER() ---';
SELECT *
FROM (
    SELECT 
        ProductID,
        ProductName,
        Category,
        Price,
        ROW_NUMBER() OVER (PARTITION BY Category ORDER BY Price DESC) AS RowNum
    FROM Products_new
) AS Ranked
WHERE RowNum <= 3;

-- 6. Use RANK() to get top 3 per category (including ties)
PRINT '--- Top 3 using RANK() ---';
SELECT *
FROM (
    SELECT 
        ProductID,
        ProductName,
        Category,
        Price,
        RANK() OVER (PARTITION BY Category ORDER BY Price DESC) AS PriceRank
    FROM Products_new
) AS Ranked
WHERE PriceRank <= 3;

-- 7. Use DENSE_RANK() to get top 3 per category (no gaps)
PRINT '--- Top 3 using DENSE_RANK() ---';
SELECT *
FROM (
    SELECT 
        ProductID,
        ProductName,
        Category,
        Price,
        DENSE_RANK() OVER (PARTITION BY Category ORDER BY Price DESC) AS DensePriceRank
    FROM Products_new
) AS Ranked
WHERE DensePriceRank <= 3;
