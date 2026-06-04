USE CustomerAnalysis;
CREATE TABLE Customers(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    Email VARCHAR(100),
    Age INT,
    JoinDate DATE,
    TotalPurchase DECIMAL(10,2)
);
truncate table customers;
SELECT * FROM Customers;

-- Top Customers by Purchase
SELECT *
FROM Customers
ORDER BY TotalPurchase DESC;

-- City-wise Revenue
select city, sum(TotalPurchase) as Revenue
from customers
group by city;

-- Rank customers using window functions
select CustomerId,CustomerName,TotalPurchase,
Rank() over (order by TotalPurchase desc) as CustomerRank
from customers;

-- Total Customers
select count(*) as TotalCustomers
from customers;

-- City-wise Customer Count
select city,count(*) as Customercount
from customers
group by city;

-- Above Average Customers
select * 
from customers 
where TotalPurchase > (
	select avg(TotalPurchase)
    from customers );

-- Customer Acquisition Trend
select year(joinDate) as Year,
	month(joinDate) as Month,
    Count(*) as newCustomers
from customers 
group by Year(joindate),Month(joindate)
order by Year,Month;