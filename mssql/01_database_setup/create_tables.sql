USE datasetDB;
GO

CREATE  TABLE Customers (
    CustomerID INT IDENTITY PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    ContactName NVARCHAR(100),
    Country NVARCHAR(50)
);

CREATE TABLE Employees (
    EmployeeID INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50)
);

CREATE TABLE Categories (
    CategoryID INT IDENTITY PRIMARY KEY,
    CategoryName NVARCHAR(50)
);

CREATE TABLE Suppliers (
    SupplierID INT IDENTITY PRIMARY KEY,
    SupplierName NVARCHAR(100),
    Country NVARCHAR(50),
);

CREATE TABLE Products (
    ProductID INT IDENTITY PRIMARY KEY,
    ProductName NVARCHAR(100),
    SupplierID INT,
    CategoryID INT,
    Price DECIMAL(10,2),
    Foreign Key (SupplierID) REFERENCES Suppliers(SupplierID),
    Foreign Key (CategoryId) REFERENCES Categories(CategoryID)
);

CREATE TABLE Shippers (
    ShipperID INT IDENTITY PRIMARY KEY,
    ShipperName NVARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT IDENTITY PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE,
    ShipperID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ShipperID) REFERENCES Shippers(ShipperID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

