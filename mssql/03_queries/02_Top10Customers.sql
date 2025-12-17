-- Top 10 Customers

USE datasetDB;
GO

-- Preparing data table
IF OBJECT_ID('dbo.Top10Customers','U') IS NULL
    BEGIN
        CREATE TABLE dbo.Top10Customers (
            CustomerID INT,
            CustomerName NVARCHAR(100),
            TotalOrders INT
        );
    END
ELSE
    BEGIN
        TRUNCATE TABLE dbo.Top10Customers;
    END

INSERT INTO dbo.Top10Customers (CustomerID, CustomerName, TotalOrders)

-- Query
SELECT TOP 10
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders

FROM Customers c
JOIN Orders o 
    ON c.CustomerID = o.CustomerID    

GROUP BY c.CustomerID, c.CustomerName
ORDER BY TotalOrders DESC;


