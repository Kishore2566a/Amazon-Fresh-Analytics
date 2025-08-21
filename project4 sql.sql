CREATE DATABASE amazon_fresh;
use amazon_fresh;
DROP TABLE customers;
DROP TABLE orders ;
ALTER TABLE customers
ADD PRIMARY KEY (CustomerID);
SELECT DISTINCT CustomerID FROM customers LIMIT 10;
ALTER TABLE customers 
MODIFY COLUMN CustomerID VARCHAR(36),
ADD PRIMARY KEY (CustomerID);
SELECT * FROM products LIMIT 10;
ALTER TABLE products
MODIFY ProductID VARCHAR(36),
ADD PRIMARY KEY (ProductID);
ALTER TABLE products
ADD CONSTRAINT fk_supplier
FOREIGN KEY (SupplierID) REFERENCES suppliers(SupplierID);
ALTER TABLE products
MODIFY COLUMN SupplierID CHAR(36);
ALTER TABLE Suppliers
ADD PRIMARY KEY (SupplierID(36));
SELECT * FROM suppliers LIMIT 10;
ALTER TABLE Suppliers
MODIFY SupplierID VARCHAR(36);

ALTER TABLE Suppliers
ADD PRIMARY KEY (SupplierID);
ALTER TABLE Orders
MODIFY COLUMN OrderID VARCHAR(36) NOT NULL;
ALTER TABLE Orders
ADD PRIMARY KEY (OrderID);
ALTER TABLE Order_Details
ADD COLUMN OrderDetailID VARCHAR(36) NOT NULL FIRST;
ALTER TABLE Order_Details
ADD PRIMARY KEY (OrderDetailID);
SELECT COUNT(*) FROM Order_Details WHERE OrderDetailID IS NULL;
UPDATE Order_Details
SET OrderDetailID = UUID()
WHERE OrderDetailID IS NULL;
ALTER TABLE Order_Details
ADD PRIMARY KEY (OrderDetailID);
ALTER TABLE Order_Details
ADD CONSTRAINT fk_order
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);
ALTER TABLE Orders
MODIFY COLUMN OrderID VARCHAR(36) NOT NULL;
ALTER TABLE Order_Details
MODIFY COLUMN OrderID VARCHAR(36) NOT NULL;
ALTER TABLE Order_Details
ADD CONSTRAINT fk_order
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);
ALTER TABLE Order_Details
ADD CONSTRAINT fk_product
FOREIGN KEY (ProductID) REFERENCES Products(ProductID);
ALTER TABLE Order_Details
MODIFY COLUMN ProductID VARCHAR(36) NOT NULL;
ALTER TABLE Order_Details
ADD CONSTRAINT fk_product FOREIGN KEY (ProductID) REFERENCES Products(ProductID);
ALTER TABLE Reviews
MODIFY COLUMN ReviewID VARCHAR(36) NOT NULL;
ALTER TABLE Reviews
ADD PRIMARY KEY (ReviewID);
ALTER TABLE Reviews
MODIFY COLUMN ProductID VARCHAR(36) NOT NULL;

ALTER TABLE Reviews
MODIFY COLUMN CustomerID VARCHAR(36) NOT NULL;
ALTER TABLE Reviews
MODIFY COLUMN ReviewID VARCHAR(36) NOT NULL;
ALTER TABLE Reviews
MODIFY COLUMN ProductID VARCHAR(36) NOT NULL;
ALTER TABLE Reviews
MODIFY COLUMN ProductID VARCHAR(36) NOT NULL;
ALTER TABLE Reviews
ADD CONSTRAINT fk_reviews_product
FOREIGN KEY (ProductID) REFERENCES Products(ProductID);
SHOW CREATE TABLE Reviews;
ALTER TABLE Reviews
ADD CONSTRAINT fk_reviews_customer
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);
ALTER TABLE Reviews
MODIFY COLUMN ProductID VARCHAR(36) NOT NULL;
ALTER TABLE Suppliers
MODIFY SupplierID VARCHAR(36) NOT NULL;

ALTER TABLE Suppliers
ADD PRIMARY KEY (SupplierID);
ALTER TABLE Products
MODIFY SupplierID VARCHAR(36) NOT NULL;
ALTER TABLE Products
ADD CONSTRAINT fk_products_supplier
FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID);
SELECT DISTINCT SupplierID
FROM Products
WHERE SupplierID NOT IN (
    SELECT SupplierID FROM Suppliers
);
ALTER TABLE Suppliers
MODIFY COLUMN SupplierID VARCHAR(36) NOT NULL;
ALTER TABLE Suppliers
ADD PRIMARY KEY (SupplierID);
SELECT ProductID
FROM Products
WHERE SupplierID NOT IN (
    SELECT SupplierID FROM Suppliers
);
SELECT ProductID
FROM Products
WHERE SupplierID NOT IN (
    SELECT SupplierID FROM Suppliers
);
DELETE FROM Order_Details
WHERE ProductID IN (
    SELECT ProductID
    FROM Products
    WHERE SupplierID NOT IN (
        SELECT SupplierID FROM Suppliers
    )
);
DELETE FROM Products
WHERE SupplierID NOT IN (
    SELECT SupplierID FROM Suppliers
);
SELECT ProductID
FROM Products
WHERE SupplierID NOT IN (
    SELECT SupplierID FROM Suppliers
);
SELECT DISTINCT ProductID
FROM Reviews
WHERE ProductID IN (
    SELECT ProductID
    FROM Products
    WHERE SupplierID NOT IN (
        SELECT SupplierID FROM Suppliers
    )
);
SELECT DISTINCT SupplierID
FROM Products
WHERE SupplierID NOT IN (
    SELECT SupplierID FROM Suppliers
);
INSERT INTO Suppliers (SupplierID, SupplierName, ContactPerson, Phone, City, State)
VALUES ('supplier_xyz', 'Unknown Supplier', 'N/A', 'N/A', 'N/A', 'N/A');
ALTER TABLE Products
ADD CONSTRAINT fk_products_supplier
FOREIGN KEY (SupplierID)
REFERENCES Suppliers(SupplierID);
SELECT DISTINCT SupplierID
FROM Products
WHERE SupplierID NOT IN (
    SELECT SupplierID FROM Suppliers
);
INSERT INTO Suppliers (SupplierID, SupplierName, ContactPerson, Phone, City, State)
VALUES ('S999', 'Unknown Supplier', 'N/A', 'N/A', 'Unknown', 'Unknown');
ALTER TABLE Products
ADD CONSTRAINT fk_products_supplier
FOREIGN KEY (SupplierID)
REFERENCES Suppliers(SupplierID);
SELECT * FROM Suppliers
WHERE SupplierID = 'S999';
DELETE FROM Suppliers
WHERE SupplierID = 'S999';
DELETE FROM Suppliers
WHERE SupplierID IN ('S999', 'supplier_xyz');
ALTER TABLE Orders
ADD CONSTRAINT pk_orders PRIMARY KEY (OrderID);
ALTER TABLE Orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);
ALTER TABLE Customers
MODIFY COLUMN CustomerID VARCHAR(50);

ALTER TABLE Orders
MODIFY COLUMN CustomerID VARCHAR(50);
ALTER TABLE Orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);
USE amazon_fresh;
SHOW TABLES;
SELECT ProductID
FROM Order_Details
WHERE ProductID IN (
    SELECT ProductID
    FROM Products
    WHERE SupplierID NOT IN (
        SELECT SupplierID
        FROM Suppliers
    )
);
SELECT ProductID
FROM Reviews
WHERE ProductID IN (
    SELECT ProductID
    FROM Products
    WHERE SupplierID NOT IN (
        SELECT SupplierID
        FROM Suppliers
    )
);
DELETE FROM Reviews
WHERE ProductID IN (
    SELECT ProductID
    FROM Products
    WHERE SupplierID NOT IN (
        SELECT SupplierID
        FROM Suppliers
    )
);
DELETE FROM Reviews
WHERE ProductID IN (
    SELECT ProductID
    FROM Products
    WHERE SupplierID NOT IN (
        SELECT SupplierID
        FROM Suppliers
    )
);
DELETE FROM Products
WHERE SupplierID NOT IN (
    SELECT SupplierID FROM Suppliers
);
ALTER TABLE Products
ADD CONSTRAINT fk_products_supplier
FOREIGN KEY (SupplierID)
REFERENCES Suppliers(SupplierID);
SELECT *
FROM Customers
WHERE City = 'Patelberg';
SELECT *
FROM Customers
WHERE City = 'Lake Jeffreyfurt';




-- 1. Set CustomerID as primary key
ALTER TABLE Customers
ADD CONSTRAINT pk_customers PRIMARY KEY (CustomerID);

-- 2. Make Age NOT NULL and ensure it's > 18
ALTER TABLE Customers
MODIFY COLUMN Age INT NOT NULL;
DELETE FROM Orders
WHERE CustomerID IN (
  SELECT CustomerID FROM Customers WHERE Age < 19
);
DELETE FROM Customers
WHERE Age < 19;
ALTER TABLE Customers
ADD CONSTRAINT chk_age CHECK (Age >= 19);

-- 3. Make Name unique
ALTER TABLE Customers
MODIFY COLUMN Name VARCHAR(100);
SELECT *
FROM Customers
WHERE Name IN (
    SELECT Name
    FROM Customers
    GROUP BY Name
    HAVING COUNT(*) > 1
);
UPDATE Customers
SET Name = 'Jennifer Miller A'
WHERE CustomerID = 'c077aa34-00c4-40b2-8870-e5866d4c9a98';

UPDATE Customers
SET Name = 'Jennifer Miller B'
WHERE CustomerID = '52023340-8b68-45f9-ae5a-3ccf76f5b732';

UPDATE Customers
SET Name = 'Patricia King A'
WHERE CustomerID = '90fc0e22-9b61-45d8-8186-30f08b67de50';

UPDATE Customers
SET Name = 'Richard Johnson A'
WHERE CustomerID = 'c4ca937f-8420-4125-838b-31e1d9a98620';

UPDATE Customers
SET Name = 'Ralph Evans A'
WHERE CustomerID = '7b9f2e74-7477-4e2d-b1e6-fb8790ecf66b';

UPDATE Customers
SET Name = 'Ralph Evans B'
WHERE CustomerID = '10c50e00-e1e3-4d0e-97c2-7f2ae0660302';
SELECT Name, COUNT(*) AS count
FROM Customers
GROUP BY Name
HAVING COUNT(*) > 1;
UPDATE Customers
SET Name = 'Michael Garcia A'
WHERE CustomerID = '3d1a9c3c-e7f9-45a9-a3a6-b19d3d8e4aca';

UPDATE Customers
SET Name = 'Michael Garcia B'
WHERE CustomerID = '1a822132-adc2-4e40-8932-2ff7ee571089';

UPDATE Customers
SET Name = 'Michael Garcia C'
WHERE CustomerID = 'ae0371e4-cc5c-4f92-9529-1d82d2d000be';
ALTER TABLE Customers
ADD CONSTRAINT uq_customer_name UNIQUE (Name);
SHOW CREATE TABLE Customers;
USE amazon_fresh;
SELECT * FROM Products;
DROP TABLE IF EXISTS Products;
SHOW CREATE TABLE order_details;
ALTER TABLE order_details DROP FOREIGN KEY fk_product;
DROP TABLE IF EXISTS Products;
SHOW CREATE TABLE reviews;
DROP SCHEMA IF EXISTS amazon_fresh;







CREATE SCHEMA amazon_fresh;
use amazon_fresh;
SELECT * FROM Products LIMIT 15;
INSERT INTO Products (ProductID, ProductName, Category, SubCategory, PricePerUnit, StockQuantity, SupplierID)
VALUES
('bdbd2e3d-b99b-4c9d-8234-fbd9e50e3c30', 'Fresh Apple', 'Fruits', 'Sub-Fruits-1', 150, 300, '0658c953-98c4-4d00-bf29-4fbfe4aca4cd'),
('c0ef7386-5067-4776-b60a-0ac75f3a96a8', 'Healthy Snack Bar', 'Snacks', 'Sub-Snacks-2', 200, 250, 'cb890936-8142-4fa3-ac60-2ecba78f8aa8'),
('0a8d3b8f-44b5-4cbf-bf22-44f3fae7b8f2', 'Organic Milk', 'Dairy', 'Sub-Dairy-1', 90, 500, '16c44a77-d01f-4154-a7b7-1f5b5dee4255');
UPDATE Products
SET StockQuantity = 350
WHERE ProductID = 'bdbd2e3d-b99b-4c9d-8234-fbd9e50e3c30';
SELECT * FROM Products WHERE ProductID = 'bdbd2e3d-b99b-4c9d-8234-fbd9e50e3c30';
DELETE FROM Suppliers
WHERE City = 'Maine?';

#task 8
DESCRIBE Reviews;
ALTER TABLE Reviews
ADD CONSTRAINT chk_rating CHECK (Rating BETWEEN 1 AND 5);
ALTER TABLE Customers
MODIFY PrimeMember VARCHAR(3) DEFAULT 'No';
SELECT * FROM Orders
WHERE OrderDate > '2024-01-01';
SELECT * FROM Orders;
SELECT p.ProductID, p.ProductName, SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM Order_Details od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSales DESC;

#task10

SELECT CustomerID, SUM(OrderAmount) AS TotalSpending
FROM orders
GROUP BY CustomerID;
SELECT CustomerID, SUM(OrderAmount) AS TotalSpending
FROM orders
GROUP BY CustomerID
ORDER BY TotalSpending DESC;
SELECT CustomerID, SUM(OrderAmount) AS TotalSpending
FROM orders
GROUP BY CustomerID
HAVING TotalSpending > 5000
ORDER BY TotalSpending DESC;

#TASK 11
SELECT
    o.OrderID,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM
    Orders o
JOIN
    Order_Details od ON o.OrderID = od.OrderID
GROUP BY
    o.OrderID;
    SELECT
    CustomerID,
    COUNT(OrderID) AS NumberOfOrders
FROM
    Orders
WHERE
    OrderDate = '2025-01-01'
GROUP BY
    CustomerID
ORDER BY
    NumberOfOrders DESC
LIMIT 1;
SELECT
    s.SupplierName,
    SUM(p.StockQuantity) AS TotalStock
FROM
    Suppliers s
JOIN
    Products p ON s.SupplierID = p.SupplierID
GROUP BY
    s.SupplierName
ORDER BY
    TotalStock DESC
LIMIT 1;

#task 12
CREATE TABLE ProductCategories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(255) NOT NULL UNIQUE
);
INSERT INTO ProductCategories (CategoryName)
SELECT DISTINCT Category FROM Products;
ALTER TABLE Products ADD COLUMN CategoryID INT;

UPDATE Products p
JOIN ProductCategories pc ON p.Category = pc.CategoryName
SET p.CategoryID = pc.CategoryID;
ALTER TABLE Products DROP COLUMN Category;

ALTER TABLE Products ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES ProductCategories(CategoryID);

#TASK 13
SELECT
    ProductID,
    SUM(Quantity * UnitPrice) AS TotalRevenue
FROM
    Order_Details
GROUP BY
    ProductID
ORDER BY
    TotalRevenue DESC
LIMIT 3;
SELECT
    CustomerID,
    Name
FROM
    Customers
WHERE
    CustomerID NOT IN (SELECT CustomerID FROM Orders);

#TASK 14
SELECT
    City,
    COUNT(*) AS PrimeMembers
FROM
    Customers
WHERE
    PrimeMember = 'Yes'
GROUP BY
    City
ORDER BY
    PrimeMembers DESC
LIMIT 5;
SELECT
    pc.CategoryName,
    COUNT(od.OrderID) AS OrderCount
FROM
    Order_Details od
JOIN
    Products p ON od.ProductID = p.ProductID
JOIN
    ProductCategories pc ON p.CategoryID = pc.CategoryID
GROUP BY
    pc.CategoryName
ORDER BY
    OrderCount DESC
LIMIT 3;





























































































