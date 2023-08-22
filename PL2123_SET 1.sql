CREATE DATABASE ChocolateSale


CREATE TABLE Items(
ItemId INT PRIMARY KEY,
ItemName VARCHAR(15)
)

CREATE TABLE Shop(
ShopId INT PRIMARY KEY,
ShopName VARCHAR(25)
)


CREATE TABLE UnitDetails
(
UnitID INT PRIMARY KEY,
Unit VARCHAR(15),
Counts INT
)
CREATE TABLE OrderSalesDetails(
ItemId INT,
ShopId INT,
UnitID INT,
Quantity INT,
UnitPrice INT,
SalesDate Date,
CONSTRAINT fk_itemid2 FOREIGN KEY(ItemId)
REFERENCES Items(ItemId),
CONSTRAINT fk_shopid FOREIGN KEY(shopId)
REFERENCES Shop(shopId),
CONSTRAINT fk_unitId FOREIGN KEY(UnitId)
REFERENCES UnitDetails(UnitId)
)

INSERT INTO Items(ItemID,ItemName)
VALUES(1,'Bar-One'),
(2,'Kitkat'),
(3,'Milky Bar'),
(4,'Munch')

INSERT INTO Shop(ShopId,ShopName)
VALUES(1,'Amal Stores'),
(2,'Jyothi Stores'),
(3,'Indira Stores')



INSERT INTO UnitDetails
VALUES(1,'Piece',1),
(2,'BoxPack',28)


INSERT INTO OrderSalesDetails(ItemId,ShopId,UnitId,Quantity,UnitPrice,SalesDate)
VALUES(1,1,1,100,10,'2018-10-05'),
(2,1,1,200,15,'2018-10-05'),
(3,1,1,50,5,'2018-10-05'),
(4,1,1,150,10,'2018-10-05'),
(1,2,2,10,280,'2018-10-10'),
(2,2,2,30,420,'2018-10-10'),
(3,2,2,40,140,'2018-10-10'),
(4,2,2,20,280,'2018-10-10'),
(1,3,2,50,280,'2018-09-15'),
(2,3,2,70,420,'2018-09-15'),
(3,3,2,30,140,'2018-10-15'),
(1,1,1,150,10,'2018-09-15'),
(2,1,1,250,15,'2018-09-15'),
(4,1,1,200,10,'2018-10-15')

--Q1.2

SELECT TOP 1 ItemName,SUM(Quantity*UnitPrice) AS Revenue FROM Items i 
INNER JOIN OrderSalesDetails o 
ON i.ItemId=o.ItemId
WHERE MONTH(SalesDate)=10 
GROUP BY i.ItemName
ORDER BY Revenue DESC 

--Q1.3
SELECT TOP 1
    i.ItemName,
    SUM(o.Quantity) AS TotalQuantitySold
FROM
    Items AS i
INNER JOIN OrderSalesDetails AS o ON i.Itemid = o.Itemid
INNER JOIN Shop AS S ON o.shopid = s.Shopid
WHERE
    s.ShopId = 1
    AND DATEPART(Month,o.salesdate)=10
GROUP BY
    i.ItemName
ORDER BY
    TotalQuantitySold DESC

--Q1.4

SELECT 
    i.ItemName,
    SUM(o.Unitprice * O.Quantity) AS TotalRevenue
FROM
OrderSalesDetails AS o
INNER JOIN Items AS i ON o.Itemid = i.Itemid
WHERE
    DATEPART(MONTH,o.salesDate) = 10
GROUP BY
    i.ItemName
HAVING
    SUM(o.Unitprice * o.Quantity) > 10000

--Q1.5
SELECT TOP 1
    S.Shopname,
    SUM(o.UnitPrice * o.Quantity) AS TotalRevenue
FROM
    Shop AS S
JOIN OrderSalesDetails AS o ON S.ShopId = o.ShopId
JOIN Items AS I ON o.Itemid = I.Itemid
WHERE
    DATEPART(MONTH,o.salesdate) = 10
GROUP BY
    S.ShopName
ORDER BY
    TotalRevenue DESC

