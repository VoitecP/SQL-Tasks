--  Top 10 Customers with made the most expensive single orders
USE datasetDB;
GO
-- Preparing data table
IF OBJECT_ID('dbo.Top200Products','U') IS NULL
    BEGIN
        CREATE TABLE dbo.Top200Products (
            ProductID INT,
            ProductName NVARCHAR(100),
            TotalSold DECIMAL(12,2),
            CountSold INT,
        );
    END
ELSE
    BEGIN
        TRUNCATE TABLE dbo.Top200Products;
    END
;


--Query
SELECT TOP 200
    p.ProductID,
    p.ProductName,
    SUM (od.Quantity) AS TotalSold,   
    COUNT(DISTINCT od.OrderID) AS CountSold

FROM OrderDetails od    
JOIN Products p  
    ON p.ProductID = od.ProductID  

GROUP BY 
    p.ProductID,
    p.ProductName 
ORDER BY 
    TotalSold DESC
    -- CountSold DESC
    ;

