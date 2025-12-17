--  Top 10 Customers with made the most expensive single orders
USE datasetDB;
GO


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
    --TotalSold DESC,
    CountSold DESC
    ;

