--������� ������� �������� ������
SELECT COUNT(*) AS [Number of categories]
FROM Categories;

--������ ����� ������ � ������� "����������� ������"(Confections)
SELECT COUNT(*) AS [Number of Confections]
FROM Products P
WHERE P.CategoryID=3;

--������ ����� ������ � ������� "����"(Beverages)
SELECT P.ProductName
FROM Products P
WHERE P.CategoryID=1;

--������ ������� ����, ����������� �� �������� ���� ������ � ����� ������� (�������� Meat/Poultry-6)
SELECT AVG(Price) AS [Average price], MAX(Price) AS [MAX price], MIN(Price) AS [MIN price]
FROM Products P
WHERE P.CategoryID=6;

--������ ������� �� ����������
SELECT AVG(DATEDIFF(dd,Convert(Date,BirthDate),
       GETDATE())/365.25) AS [Average age]
FROM Employees;

--������� ������� ��������� ������� �볺���( � ���� ��������� ����� �볺���)
SELECT COUNT(*) as [COUNT Name]
FROM Orders O join Customers C on O.CustomerID = C.ID AND C.CustomerName='Vehicula Ltd';

--������ �������� ����� ������ ���������� ������ �볺����(� ���� ���������
--����� �볺���, ��������� 'Romero y tomillo'), ����� �������� �� ���� quantity
SELECT SUM(OD.Quantity) as [COUNT Name]
FROM Orders O join OrderDetails OD on O.CustomerID = OD.ID AND OD.OrderID=O.ID join Customers C on C.CustomerName='Vehicula Ltd';

--������ �������� ������� ����, �� ��� ������� ������ ������ �볺��(� ����
--��������� ����� �볺���, ��������� 'Romero y tomillo')
SELECT SUM(P.Price*OD.Quantity) AS [Sum money]
FROM Products P, OrderDetails OD, Customers C, Orders O
WHERE C.CustomerName = 'Vehicula Ltd' AND C.ID=O.CustomerID AND OD.OrderID=O.ID AND OD.ProductID=P.ID;


--������� ������� ��������� �� ������� �볺���(���������� ����� �볺���)
SELECT COUNT(*) AS 'COUNT Order', C.CustomerName
FROM Customers C, Orders O
WHERE C.ID=O.CustomerID
GROUP BY C.CustomerName;

--������� ������� ��������� �� ������� �볺���, ������� ���� ������� ����
SELECT COUNT(*) AS 'COUNT Order', C.CustomerName
FROM Customers C, Orders O
WHERE C.ID=O.CustomerID AND Convert(Nvarchar,(O.OrderDate)) > '2020' --�������� ��� Date � Nvarchar
GROUP BY C.CustomerName;

--������� ������� ��������� �� ������� ����(��� �����, ���� ���� � ����� ������ ����)???
SELECT COUNT(*) AS 'COUNT Order', O.OrderDate
FROM Orders O
WHERE C.ID=O.CustomerID AND Convert(Nvarchar,(O.OrderDate)) > '2020' --�������� ��� Date � Nvarchar
GROUP BY O.OrderDate;

--������� ������� ��������� �� ������� �볺���, �� ������� ����� 5 ���������
SELECT COUNT(O.ID) AS 'Count Order', O.CustomerID
FROM Orders O join Customers C on O.CustomerID=C.ID
GROUP BY O.CustomerID
HAVING COUNT(O.ID) > 5;

--������� ������� ������ �� ������� ����������(sum)
SELECT SUM(OD.Quantity) AS 'Order Quantity', O.ID
FROM Orders O join OrderDetails OD on O.ID=OD.OrderID
GROUP BY O.ID;

--������ ������� ������, �� ������������ � ����� �����
SELECT SUM(OD.Quantity) AS 'Order Quantity', C.Country
FROM Customers C join Orders O on C.ID=O.CustomerID join OrderDetails OD on O.ID=OD.OrderID
GROUP BY C.Country;

--������� ������� (���� �������� * ������� ��������) �� ������� ����������(sum)
SELECT SUM(P.Price*OD.Quantity) AS 'Cost Order', O.ID
FROM Products P join OrderDetails OD on P.ID=OD.ProductID join Orders O on O.ID=OD.OrderID
GROUP BY O.ID;