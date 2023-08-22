CREATE DATABASE Company

CREATE TABLE Manufacturer(
MfName VARCHAR(30) PRIMARY KEY,
City VARCHAR(20),
State VARCHAR(20)
)

CREATE TABLE Employee(
EmployeeId INT PRIMARY KEY,
EmpName VARCHAR(30),
Area_code VARCHAR(10),
Phone VARCHAR(10),
Email VARCHAR(25)
)

CREATE TABLE Computer(
SerialNumber INT PRIMARY KEY,
Mfname VARCHAR(30),
Model VARCHAR(20),
Weights DECIMAL(4,2),
EmployeeId INT
CONSTRAINT fk_MfName FOREIGN KEY(Mfname)
REFERENCES Manufacturer(Mfname),
CONSTRAINT fk_Empid FOREIGN KEY(EmployeeId)
REFERENCES Employee(EmployeeId)
)

INSERT INTO Manufacturer (MfName, city, state)
VALUES
    ('Anu', 'south dakota', 'africa'),
    ('Manu', 'Kozhikode', 'india'),
    ('Sanu', 'Ernakulam', 'India');

INSERT INTO Employee (EmployeeId, EmpName, area_code, phone, email)
VALUES
    (1, 'Asha', '412', '9846852510', 'asha@gmail.com'),
    (2, 'Minnu', '226', '7576456332', 'minnu@gmail.com'),
    (3, 'Ammu', '124', '8064536786', 'ammu@gmail.com');

INSERT INTO Computer (SerialNumber, Model, Weights, EmployeeId, MfName)
VALUES
    (101, 'Model1', 8.5, 1, 'Anu'),
    (102, 'Model2', 8.4, 2, 'Manu'),
    (103, 'Model3', 10.7, 3, 'Sanu');
--Q1
SELECT MfName
FROM Manufacturer
WHERE city = 'South Dakota';

--Q2
SELECT AVG(Weights) AS 'average weight' FROM Computer;

--Q3
SELECT Empname FROM Employee WHERE Area_code LIKE '2%';

--Q4
SELECT SerialNumber
FROM Computer
WHERE weights < (SELECT AVG(weights) FROM Computer);

--Q5
SELECT MfName FROM Manufacturer WHERE MfName NOT IN (SELECT MfName FROM Computer) 

--Q6
SELECT e.EmpName, c.SerialNumber, m.City FROM Employee e
JOIN computer c ON e.EmployeeID = c.EmployeeID
JOIN manufacturer m ON c.MfName = m.MfName

--Q7

CREATE PROCEDURE ComputerDetails
    @EmployeeId int
AS
BEGIN
    SELECT Computer.SerialNumber, Manufacturer.mfname, Model, weights
    FROM computer
    INNER JOIN employee ON Computer.EmployeeId = Employee.EmployeeId
    INNER JOIN manufacturer ON Computer.MfName = Manufacturer.MfName
    WHERE Employee.EmployeeId =@EmployeeId;
END;
  EXEC ComputerDetails @employeeid=3