USE datasetDB;
GO


-- STAGING TABLES

-- Customers 
CREATE TABLE dbo.Customers_Staging (
    CustomerName NVARCHAR(100),
    ContactName NVARCHAR(100),
    Country NVARCHAR(50)
);


-- Employees 
CREATE TABLE dbo.Employees_Staging (
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50)
);

-- Categories 
CREATE TABLE dbo.Categories_Staging (   
    CategoryName NVARCHAR(50)
);  

-- Suppliers        
CREATE TABLE dbo.Suppliers_Staging (
    SupplierName NVARCHAR(100),
    Country NVARCHAR(50)
);

-- Products    
CREATE TABLE dbo.Products_Staging ( 
    ProductName NVARCHAR(100),
    SupplierID INT,
    CategoryID INT,
    -- Price DECIMAL(10,2)
    Price NVARCHAR(20)
    
);  

-- Shippers         
CREATE TABLE dbo.Shippers_Staging ( 
    ShipperName NVARCHAR(100)
);  

-- Orders       
CREATE TABLE dbo.Orders_Staging (   
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE,
    ShipperID INT
);          

-- OrderDetails        
CREATE TABLE dbo.OrderDetails_Staging ( 
    OrderID INT,
    ProductID INT,
    Quantity INT
);  

-- Bulk Insert

-- Customers
BULK INSERT dbo.Customers_Staging
FROM 'C:\GitHub\SQL-Tasks\mssql\02_data_import\csv\Customers.csv'   
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001'  
);

-- Employees
BULK INSERT dbo.Employees_Staging 
FROM 'C:\GitHub\SQL-Tasks\mssql\02_data_import\csv\Employees.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001'  
);   

-- Categories
BULK INSERT dbo.Categories_Staging
-- FROM '.csv\Categories.csv'
FROM 'C:\GitHub\SQL-Tasks\mssql\02_data_import\csv\Categories.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001'  
);

-- Suppliers
BULK INSERT dbo.Suppliers_Staging       
FROM 'C:\GitHub\SQL-Tasks\mssql\02_data_import\csv\Suppliers.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001'  
);

-- Products
BULK INSERT dbo.Products_Staging   
FROM 'C:\GitHub\SQL-Tasks\mssql\02_data_import\csv\Products.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001'  
);  

-- Shippers
BULK INSERT dbo.Shippers_Staging        
FROM 'C:\GitHub\SQL-Tasks\mssql\02_data_import\csv\Shippers.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001'  
);  

-- Orders
BULK INSERT dbo.Orders_Staging      
FROM 'C:\GitHub\SQL-Tasks\mssql\02_data_import\csv\Orders.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001'  
);

-- OrderDetails
BULK INSERT dbo.OrderDetails_Staging        
FROM 'C:\GitHub\SQL-Tasks\mssql\02_data_import\csv\OrderDetails.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001'  
);

-- Data migration

-- Customers
INSERT INTO dbo.Customers (CustomerName, ContactName, Country)
SELECT CustomerName, ContactName, Country   
FROM dbo.Customers_Staging;

-- Employees
INSERT INTO dbo.Employees (FirstName, LastName)
SELECT FirstName, LastName      
FROM dbo.Employees_Staging;

-- Categories
INSERT INTO dbo.Categories (CategoryName)   
SELECT CategoryName
FROM dbo.Categories_Staging;

-- Suppliers
INSERT INTO dbo.Suppliers (SupplierName, Country)   
SELECT SupplierName, Country
FROM dbo.Suppliers_Staging;

-- Products
INSERT INTO dbo.Products (ProductName, SupplierID, CategoryID, Price)   
SELECT ProductName, SupplierID, CategoryID
    -- , Price
    , CAST ( 
        REPLACE ( 
            REPLACE(Price, '"',''), ',','.'
            ) AS DECIMAL(10,2)         
        )

FROM dbo.Products_Staging;

-- Shippers
INSERT INTO dbo.Shippers (ShipperName)
SELECT ShipperName
FROM dbo.Shippers_Staging;

--Orders
INSERT INTO dbo.Orders (CustomerID, EmployeeID, OrderDate, ShipperID)
SELECT CustomerID, EmployeeID, OrderDate, ShipperID
FROM dbo.Orders_Staging;

--OrderDetails
INSERT INTO dbo.OrderDetails (OrderID, ProductID, Quantity) 
SELECT OrderID, ProductID, Quantity
FROM dbo.OrderDetails_Staging;

-- -- Truncate staging tables

-- TRUNCATE TABLE dbo.Customers_Staging;
-- TRUNCATE TABLE dbo.Employees_Staging;
-- TRUNCATE TABLE dbo.Categories_Staging;  
-- TRUNCATE TABLE dbo.Suppliers_Staging;
-- TRUNCATE TABLE dbo.Products_Staging;
-- TRUNCATE TABLE dbo.Shippers_Staging;
-- TRUNCATE TABLE dbo.Orders_Staging;
-- TRUNCATE TABLE dbo.OrderDetails_Staging;

-- Drop staging tables

DROP TABLE dbo.Customers_Staging;
DROP TABLE dbo.Employees_Staging;
DROP TABLE dbo.Categories_Staging;
DROP TABLE dbo.Suppliers_Staging;
DROP TABLE dbo.Products_Staging;
DROP TABLE dbo.Shippers_Staging;
DROP TABLE dbo.Orders_Staging;
DROP TABLE dbo.OrderDetails_Staging;





