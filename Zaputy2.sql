--Завдання 2.
-- Побудувати однотабличні(на основі одної  з таблиць) sql - запити для виконання наступних дій

-- вибрати товари з ціною від 10  до 20(скористатися операцією BETWEEN)
SELECT *
FROM Products P
WHERE P.Price BETWEEN 10 AND 20;

-- вибрати дані про постачальників з країн China, Spain, Argentina (скористатися оператором IN)
SELECT *
FROM Customers
WHERE Country IN ('China', 'France', 'Argentina');

--	вивести країни постачальників БЕЗ повторів(скористатися SELECT DISTINCT ....)
SELECT DISTINCT Country FROM Customers;

--	збільшити ціни товарів на 10% , що постачаютьcя певним постачальником
SELECT P.ProductName, P.Price*0.1 AS 'Price +10%'
FROM Products P;

-- вибрати замовлення, які зроблені у певному місяці
SELECT ID, OrderDate FROM Orders
WHERE MONTH(OrderDate) = 10;

-- вивести працівників, молодших від 30 років
SELECT * FROM Employees
WHERE BirthDate > '01/01/1991';

--	вивести імена клієнтів, які починаються на деякі букви (наприклад, A B або  С, скористатися Like '[ABC]%' )
SELECT * FROM Suppliers
WHERE SupplierName LIKE '[ABC]%';

--	вивести назви продуктів , впорядковані за зростанням
SELECT * FROM Products
ORDER BY ProductName;

--	вивести товари, впорядковані за типом(по зростанню) та  ціною(спаданням)
SELECT * FROM Products
ORDER BY CategoryID ASC, Price DESC;

--Завдання 3.
--Створити багатотабличні запити та запити з використанням агрегатних функцій для створеної  бази даних Магазин.

--	Вивести кількість категорій товарів
SELECT COUNT(*) AS [Number of categories]
FROM Categories;

--	Знайти число товарів у категорії "Кондитерські вироби"(Confections)
SELECT COUNT(P.ID) AS [Number products]
FROM Categories C join Products P ON C.Id=P.CategoryID
WHERE C.CategoryName = 'Confections';

--	Знати назви товарів з категорії "Напої"(Beverages)
SELECT P.ProductName
FROM Products P
WHERE P.CategoryID=1;

--	Знайти середню ціну, максимальну та мінімальну ціни товарів у певній категорії
SELECT AVG(Price) AS [Average price], MAX(Price) AS [MAX price], MIN(Price) AS [MIN price]
FROM Products P
WHERE P.CategoryID=6;

--	Знайти середній вік працівників
SELECT AVG(DATEDIFF(dd,Convert(Date,BirthDate),
       GETDATE())/365.25) AS [Average age]
FROM Employees;

--	Знайти товари(назва, ціна, упаковка), які постачаються з певної країни (Італії чи ін.)
SELECT P.ProductName, P.Price, P.Unit, S.Country
FROM Products P join Suppliers S ON S.ID=P.SupplierID
GROUP BY S.Country, P.ProductName, P.Price, P.Unit
HAVING S.Country = 'China';

--	Вивести назви товарів, імена(назви) клієнтів та назви постачальників товарів
SELECT P.ProductName, S.SupplierName, C.CustomerName
FROM Products P join Suppliers S ON S.ID=P.SupplierID join OrderDetails OD ON P.ID=OD.ProductID join Orders O ON O.ID=OD.OrderID join Customers C ON C.ID=O.CustomerID
GROUP BY P.ProductName, S.SupplierName, C.CustomerName;

--	Вивести назви постачальників морських продуктів(Seafood)
SELECT S.SupplierName, C.CategoryName
FROM Products P join Suppliers S ON S.ID=P.SupplierID join Categories C ON C.Id=P.CategoryID
GROUP BY S.SupplierName, C.CategoryName
HAVING C.CategoryName = 'Seafood';

--	Знайти скільки замовлень виконав певний перевізник(в умові вказувати назву перевізника, наприклад 'Speedy Express')
SELECT COUNT(O.ID), S.ShipperName
FROM Orders O join Shippers S ON S.ID=O.ShipperID
GROUP BY  S.ShipperName
HAVING S.ShipperName = 'Imperdiet Dictum Incorporated';

--	Вивести дані про замовлення (номер замовлення, назва клієнта, ім’я працівника, назва перевізника) за певний місяць певного року
SELECT O.ID AS 'Order', C.CustomerName, S.ShipperName, E.FirstName + ' '+ E.LastName AS 'Full Name', O.OrderDate
FROM Orders O join Shippers S ON S.ID=O.ShipperID join Customers C ON C.ID=O.CustomerID join Employees E ON E.ID=O.EmployeeID
WHERE MONTH(O.OrderDate) = 10 AND YEAR(O.OrderDate) = 2020;

--	Вивести дані про виконані замовлення певного клієнта  (номер замовлення, назва клієнта, ім’я працівника, назва перевізника)
SELECT O.ID AS 'Order', C.CustomerName, S.ShipperName, E.FirstName + ' '+ E.LastName AS 'Full Name'
FROM Orders O join Shippers S ON S.ID=O.ShipperID join Customers C ON C.ID=O.CustomerID join Employees E ON E.ID=O.EmployeeID
WHERE C.CustomerName = 'Vehicula Ltd';

--	Вивести кількість   замовлень певного клієнта( в умові вказувати назву клієнта)
SELECT COUNT(O.ID) AS 'Number Order', C.CustomerName
FROM Orders O join Customers C ON C.ID=O.CustomerID
GROUP BY C.CustomerName
HAVING C.CustomerName = 'Magna Corp.';

-- Знайти загальне число товарів замовлених певним клієнтом(в умові вказувати назву клієнта, наприклад 'Romero y tomillo'),
-- тобто сумувати по полю quantity
SELECT SUM(OD.Quantity) AS 'Quantity', C.CustomerName
FROM Orders O join Customers C ON C.ID=O.CustomerID join OrderDetails OD ON O.ID=OD.OrderID
GROUP BY C.CustomerName
HAVING C.CustomerName = 'Magna Corp.';

--	Знайти загальну грошову  суму, на яку  замовив товарів  певний клієнт(в умові вказувати назву клієнта, наприклад 'Romero y tomillo')
SELECT SUM(P.Price*OD.Quantity) AS 'Suma order', C.CustomerName
FROM Orders O join Customers C ON C.ID=O.CustomerID join OrderDetails OD ON O.ID=OD.OrderID join Products P ON P.ID=OD.ProductID
GROUP BY C.CustomerName
HAVING C.CustomerName = 'Magna Corp.';
