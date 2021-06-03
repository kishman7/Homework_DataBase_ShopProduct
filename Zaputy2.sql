--�������� 2.
-- ���������� �����������(�� ����� ����  � �������) sql - ������ ��� ��������� ��������� ��

-- ������� ������ � ����� �� 10  �� 20(������������ ��������� BETWEEN)
SELECT *
FROM Products P
WHERE P.Price BETWEEN 10 AND 20;

-- ������� ��� ��� ������������� � ���� China, Spain, Argentina (������������ ���������� IN)
SELECT *
FROM Customers
WHERE Country IN ('China', 'France', 'Argentina');

--	������� ����� ������������� ��� �������(������������ SELECT DISTINCT ....)
SELECT DISTINCT Country FROM Customers;

--	�������� ���� ������ �� 10% , �� ����������c� ������ ��������������
SELECT P.ProductName, P.Price*0.1 AS 'Price +10%'
FROM Products P;

-- ������� ����������, �� ������� � ������� �����
SELECT ID, OrderDate FROM Orders
WHERE MONTH(OrderDate) = 10;

-- ������� ����������, �������� �� 30 ����
SELECT * FROM Employees
WHERE BirthDate > '01/01/1991';

--	������� ����� �볺���, �� ����������� �� ���� ����� (���������, A B ���  �, ������������ Like '[ABC]%' )
SELECT * FROM Suppliers
WHERE SupplierName LIKE '[ABC]%';

--	������� ����� �������� , ����������� �� ����������
SELECT * FROM Products
ORDER BY ProductName;

--	������� ������, ����������� �� �����(�� ���������) ��  �����(���������)
SELECT * FROM Products
ORDER BY CategoryID ASC, Price DESC;

--�������� 3.
--�������� ������������� ������ �� ������ � ������������� ���������� ������� ��� ��������  ���� ����� �������.

--	������� ������� �������� ������
SELECT COUNT(*) AS [Number of categories]
FROM Categories;

--	������ ����� ������ � ������� "����������� ������"(Confections)
SELECT COUNT(P.ID) AS [Number products]
FROM Categories C join Products P ON C.Id=P.CategoryID
WHERE C.CategoryName = 'Confections';

--	����� ����� ������ � ������� "����"(Beverages)
SELECT P.ProductName
FROM Products P
WHERE P.CategoryID=1;

--	������ ������� ����, ����������� �� �������� ���� ������ � ����� �������
SELECT AVG(Price) AS [Average price], MAX(Price) AS [MAX price], MIN(Price) AS [MIN price]
FROM Products P
WHERE P.CategoryID=6;

--	������ ������� �� ����������
SELECT AVG(DATEDIFF(dd,Convert(Date,BirthDate),
       GETDATE())/365.25) AS [Average age]
FROM Employees;

--	������ ������(�����, ����, ��������), �� ������������ � ����� ����� (���볿 �� ��.)
SELECT P.ProductName, P.Price, P.Unit, S.Country
FROM Products P join Suppliers S ON S.ID=P.SupplierID
GROUP BY S.Country, P.ProductName, P.Price, P.Unit
HAVING S.Country = 'China';

--	������� ����� ������, �����(�����) �볺��� �� ����� ������������� ������
SELECT P.ProductName, S.SupplierName, C.CustomerName
FROM Products P join Suppliers S ON S.ID=P.SupplierID join OrderDetails OD ON P.ID=OD.ProductID join Orders O ON O.ID=OD.OrderID join Customers C ON C.ID=O.CustomerID
GROUP BY P.ProductName, S.SupplierName, C.CustomerName;

--	������� ����� ������������� �������� ��������(Seafood)
SELECT S.SupplierName, C.CategoryName
FROM Products P join Suppliers S ON S.ID=P.SupplierID join Categories C ON C.Id=P.CategoryID
GROUP BY S.SupplierName, C.CategoryName
HAVING C.CategoryName = 'Seafood';

--	������ ������ ��������� ������� ������ ���������(� ���� ��������� ����� ����������, ��������� 'Speedy Express')
SELECT COUNT(O.ID), S.ShipperName
FROM Orders O join Shippers S ON S.ID=O.ShipperID
GROUP BY  S.ShipperName
HAVING S.ShipperName = 'Imperdiet Dictum Incorporated';

--	������� ��� ��� ���������� (����� ����������, ����� �볺���, ��� ����������, ����� ����������) �� ������ ����� ������� ����
SELECT O.ID AS 'Order', C.CustomerName, S.ShipperName, E.FirstName + ' '+ E.LastName AS 'Full Name', O.OrderDate
FROM Orders O join Shippers S ON S.ID=O.ShipperID join Customers C ON C.ID=O.CustomerID join Employees E ON E.ID=O.EmployeeID
WHERE MONTH(O.OrderDate) = 10 AND YEAR(O.OrderDate) = 2020;

--	������� ��� ��� ������� ���������� ������� �볺���  (����� ����������, ����� �볺���, ��� ����������, ����� ����������)
SELECT O.ID AS 'Order', C.CustomerName, S.ShipperName, E.FirstName + ' '+ E.LastName AS 'Full Name'
FROM Orders O join Shippers S ON S.ID=O.ShipperID join Customers C ON C.ID=O.CustomerID join Employees E ON E.ID=O.EmployeeID
WHERE C.CustomerName = 'Vehicula Ltd';

--	������� �������   ��������� ������� �볺���( � ���� ��������� ����� �볺���)
SELECT COUNT(O.ID) AS 'Number Order', C.CustomerName
FROM Orders O join Customers C ON C.ID=O.CustomerID
GROUP BY C.CustomerName
HAVING C.CustomerName = 'Magna Corp.';

-- ������ �������� ����� ������ ���������� ������ �볺����(� ���� ��������� ����� �볺���, ��������� 'Romero y tomillo'),
-- ����� �������� �� ���� quantity
SELECT SUM(OD.Quantity) AS 'Quantity', C.CustomerName
FROM Orders O join Customers C ON C.ID=O.CustomerID join OrderDetails OD ON O.ID=OD.OrderID
GROUP BY C.CustomerName
HAVING C.CustomerName = 'Magna Corp.';

--	������ �������� �������  ����, �� ���  ������� ������  ������ �볺��(� ���� ��������� ����� �볺���, ��������� 'Romero y tomillo')
SELECT SUM(P.Price*OD.Quantity) AS 'Suma order', C.CustomerName
FROM Orders O join Customers C ON C.ID=O.CustomerID join OrderDetails OD ON O.ID=OD.OrderID join Products P ON P.ID=OD.ProductID
GROUP BY C.CustomerName
HAVING C.CustomerName = 'Magna Corp.';
