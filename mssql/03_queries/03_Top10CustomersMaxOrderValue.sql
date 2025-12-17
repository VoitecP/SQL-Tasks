--  Top 10 Customers with made the most expensive single orders
USE datasetDB;
GO

-- Preparing data table
IF OBJECT_ID('dbo.Top10CustomersTopSingleOrders','U') IS NULL
    BEGIN
        CREATE TABLE dbo.Top10CustomersTopSingleOrders (
            CustomerID INT,
            CustomerName NVARCHAR(100),
            MaxOrderValue DECIMAL(12,2)
        );
    END
ELSE
    BEGIN
        TRUNCATE TABLE dbo.Top10CustomersTopSingleOrders;
    END
;

-- CTE Common Table Expression
WITH OrderValues AS (
    SELECT
        o.OrderID,
        o.CustomerID,
        SUM (od.Quantity * p.Price) AS OrderTotal

    FROM Orders o
    JOIN OrderDetails od ON od.OrderID = o.OrderID
    JOIN Products p ON p.ProductID = od.ProductID
    GROUP BY o.OrderID, o.CustomerID
),
CustomerMaxOrders AS (
    SELECT
        CustomerID,
        MAX (OrderTotal) AS MaxOrderValue
    
    FROM OrderValues
    GROUP BY CustomerID
)

--Query
INSERT INTO dbo.Top10CustomersTopSingleOrders (CustomerID, CustomerName, MaxOrderValue)

SELECT TOP 10
    c.CustomerID,
    c.CustomerName,
    cmo.MaxOrderValue

FROM CustomerMaxOrders cmo    
JOIN Customers c ON c.CustomerID = cmo.CustomerID
ORDER BY cmo.MaxOrderValue DESC;

