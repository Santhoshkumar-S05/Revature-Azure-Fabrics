CREATE DATABASE ProductManagement;
USE ProductManagement;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    UnitPrice DECIMAL(10,2),
    StockQty INT
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID)
    REFERENCES Products(ProductID)
);

INSERT INTO Products VALUES
(101,'Laptop','Electronics',55000,50),
(102,'Mouse','Electronics',800,150),
(103,'Keyboard','Electronics',1200,100),
(104,'Monitor','Electronics',15000,40),
(105,'Printer','Electronics',12000,30);

INSERT INTO Customers VALUES
(1,'Ravi','Chennai'),
(2,'Priya','Bangalore'),
(3,'Arun','Hyderabad'),
(4,'Sneha','Mumbai');

INSERT INTO Orders VALUES
(1001,1,'2026-01-10'),
(1002,2,'2026-01-15'),
(1003,3,'2026-01-20'),
(1004,1,'2026-02-05');

INSERT INTO OrderDetails VALUES
(1,1001,101,2),
(2,1001,102,3),
(3,1002,103,5),
(4,1003,104,1),
(5,1004,105,2);

DELIMITER //

CREATE PROCEDURE GetProductsByCategory(
    IN p_category VARCHAR(50)
)
BEGIN

    SELECT *
    FROM Products
    WHERE Category = p_category;

END //

DELIMITER ;

CALL GetProductsByCategory('Electronics');

DELIMITER //

CREATE PROCEDURE DeleteOrder(
    IN p_orderid INT
)
BEGIN

    DELETE FROM OrderDetails
    WHERE OrderID = p_orderid;

    DELETE FROM Orders
    WHERE OrderID = p_orderid;

END //

DELIMITER ;

CALL DeleteOrder(1004);

DELIMITER //

CREATE FUNCTION AverageOrderValue()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

    DECLARE avg_value DECIMAL(10,2);

    SELECT AVG(OrderTotal)
    INTO avg_value
    FROM
    (
        SELECT SUM(p.UnitPrice * od.Quantity) AS OrderTotal
        FROM OrderDetails od
        JOIN Products p
        ON od.ProductID = p.ProductID
        GROUP BY od.OrderID
    ) AS OrderValues;

    RETURN avg_value;

END //

DELIMITER ;

SELECT AverageOrderValue();

DELIMITER //

CREATE FUNCTION CountCustomerOrders(
    p_customerid INT
)
RETURNS INT
DETERMINISTIC
BEGIN

    DECLARE total_orders INT;

    SELECT COUNT(*)
    INTO total_orders
    FROM Orders
    WHERE CustomerID = p_customerid;

    RETURN total_orders;

END //

DELIMITER ;

SELECT CountCustomerOrders(1);

DELIMITER //

CREATE PROCEDURE TopSellingProducts()
BEGIN

    SELECT
        p.ProductID,
        p.ProductName,
        SUM(od.Quantity) AS TotalSold
    FROM Products p
    JOIN OrderDetails od
        ON p.ProductID = od.ProductID
    GROUP BY
        p.ProductID,
        p.ProductName
    ORDER BY TotalSold DESC;

END //

DELIMITER ;
CALL TopSellingProducts();