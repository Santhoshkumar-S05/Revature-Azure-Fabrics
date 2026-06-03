create database Product;
use  Product;

create table ProductOrders(
	orderID int,
    Orderdate date,
    customerID int,
    productId int ,
    ProductName varchar(100),
    category varchar(50),
    quantity int,
    unitprice decimal(10,2),
    salesamount decimal(12,2),
    primary key(OrderID,productID)
    );
    
insert into ProductOrders values
(1,'2026-01-05',1001,101,'Laptop','Electronics',2,60000,120000),
(1,'2026-01-05',1001,102,'Mobile','Electronics',1,25000,25000),
(2,'2026-01-10',1002,103,'Printer','Electronics',3,12000,36000),
(3,'2026-01-15',1003,104,'Desk','Furniture',2,8000,16000),
(3,'2026-01-15',1003,105,'Chair','Furniture',4,3000,12000),
(4,'2026-02-05',1004,101,'Laptop','Electronics',1,60000,60000),
(4,'2026-02-05',1004,103,'Printer','Electronics',2,12000,24000),
(5,'2026-02-10',1005,102,'Mobile','Electronics',3,25000,75000),
(5,'2026-02-10',1005,104,'Desk','Furniture',1,8000,8000),
(6,'2026-03-01',1006,105,'Chair','Furniture',5,3000,15000),
(7,'2026-03-05',1007,101,'Laptop','Electronics',2,60000,120000),
(8,'2026-03-12',1008,102,'Mobile','Electronics',4,25000,100000);


select productId,productName,salesamount,
row_number() over(
	order by salesamount desc) as rownum
    from ProductOrders;
    
SELECT ProductName,
SUM(SalesAmount) AS TotalSales,
RANK() OVER(ORDER BY SUM(SalesAmount) DESC) AS ProductRank
FROM ProductOrders
GROUP BY ProductName;


SELECT ProductName,
SUM(Quantity) AS TotalQuantity,
DENSE_RANK() OVER(ORDER BY SUM(Quantity) DESC) AS ProductRank
FROM ProductOrders
GROUP BY ProductName;

SELECT *
FROM (
    SELECT ProductName,
           SUM(SalesAmount) AS TotalSales,
           DENSE_RANK() OVER(ORDER BY SUM(SalesAmount) DESC) AS rnk
    FROM ProductOrders
    GROUP BY ProductName
) x
WHERE rnk <= 3;


SELECT ProductName,
SalesAmount,
LAG(SalesAmount) OVER(ORDER BY OrderDate) AS PreviousSales
FROM ProductOrders;

SELECT ProductName,
SalesAmount,
LEAD(SalesAmount) OVER(ORDER BY OrderDate) AS NextSales
FROM ProductOrders;

SELECT OrderDate,
SalesAmount,
SUM(SalesAmount)
OVER(ORDER BY OrderDate) AS RunningTotal
FROM ProductOrders;

SELECT ProductName,
OrderDate,
SalesAmount,
SUM(SalesAmount)
OVER(PARTITION BY ProductName ORDER BY OrderDate) AS CumulativeSales
FROM ProductOrders;

SELECT Category,
ProductName,
SalesAmount,
FIRST_VALUE(SalesAmount)
OVER(PARTITION BY Category ORDER BY SalesAmount DESC) AS HighestSales
FROM ProductOrders;

SELECT Category,
ProductName,
SalesAmount,
LAST_VALUE(SalesAmount)
OVER(
PARTITION BY Category
ORDER BY SalesAmount
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) AS LowestSales
FROM ProductOrders;
	
SELECT ProductName,
SalesAmount,
SalesAmount -
LAG(SalesAmount) OVER(ORDER BY OrderDate) AS Difference
FROM ProductOrders;


SELECT OrderDate,
SalesAmount,
AVG(SalesAmount)
OVER(
ORDER BY OrderDate
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS MovingAverage
FROM ProductOrders;

SELECT *
FROM (
    SELECT *,
    AVG(SalesAmount)
    OVER(PARTITION BY Category) AS AvgSales
    FROM ProductOrders
) x
WHERE SalesAmount > AvgSales;

SELECT ProductName,
SalesAmount,
NTILE(4)
OVER(ORDER BY SalesAmount DESC) AS Quartile
FROM ProductOrders;

SELECT *
FROM (
    SELECT ProductName,
           SUM(SalesAmount) AS TotalSales,
           DENSE_RANK() OVER(ORDER BY SUM(SalesAmount) DESC) AS rnk
    FROM ProductOrders
    GROUP BY ProductName
) x
WHERE rnk = 2;

SELECT ProductName,
Category,
SalesAmount,
FIRST_VALUE(SalesAmount)
OVER(PARTITION BY Category ORDER BY SalesAmount DESC) AS CategoryLeader
FROM ProductOrders;

SELECT MonthSales,
MonthSales -
LAG(MonthSales) OVER(ORDER BY SalesMonth) AS Growth
FROM (
    SELECT MONTH(OrderDate) AS SalesMonth,
           SUM(SalesAmount) AS MonthSales
    FROM ProductOrders
    GROUP BY MONTH(OrderDate)
) x;

SELECT ProductName,
OrderDate,
SalesAmount
FROM (
    SELECT *,
    LAG(SalesAmount)
    OVER(PARTITION BY ProductName ORDER BY OrderDate) AS PrevSales
    FROM ProductOrders
) x
WHERE SalesAmount > PrevSales;

SELECT ProductName,
SUM(SalesAmount) AS TotalSales,
DENSE_RANK()
OVER(ORDER BY SUM(SalesAmount) DESC) AS LeaderboardRank
FROM ProductOrders
GROUP BY ProductName;