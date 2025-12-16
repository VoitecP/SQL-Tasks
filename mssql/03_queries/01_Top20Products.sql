-- Preparing data table
IF OBJECT_ID('dbo.Top20Products','U') IS NULL
    BEGIN
        CREATE TABLE dbo.Top20Products (
            ProductID INT,
            ProductName NVARCHAR(100),
            Price DECIMAL(10,2)
        );
    END
ELSE
    BEGIN
        TRUNCATE TABLE dbo.Top20Products;
    END

INSERT INTO dbo.Top20Products (ProductID, ProductName, Price)

-- Query
SELECT TOP 20
    ProductID,
    ProductName,
    Price
FROM Products
ORDER BY Price DESC;


