--Вивести кількість категорій товарів
SELECT COUNT(*) AS [Number of categories]
FROM Categories;

--Знайти число товарів у категорії "Кондитерські вироби"(Confections)
SELECT COUNT(*) AS [Number of Confections]
FROM Products P
WHERE P.CategoryID=3;

--Знайти назви товарів з категорії "Напої"(Beverages)
SELECT P.ProductName
FROM Products P
WHERE P.CategoryID=1;

--Знайти середню ціну, максимальну та мінімальну ціни товарів у певній категорії (Категорія Meat/Poultry-6)
SELECT AVG(Price) AS [Average price], MAX(Price) AS [MAX price], MIN(Price) AS [MIN price]
FROM Products P
WHERE P.CategoryID=6;

--Знайти середній вік працівників
SELECT AVG(DATEDIFF(dd,Convert(Date,BirthDate),
       GETDATE())/365.25) AS [Average age]
FROM Employees;

--Вивести кількість замовлень певного клієнта( в умові вказувати назву клієнта)
SELECT COUNT(*) as [COUNT Name]
FROM Orders O join Customers C on O.CustomerID = C.ID AND C.CustomerName='Vehicula Ltd';

--Знайти загальне число товарів замовлених певним клієнтом(в умові вказувати
--назву клієнта, наприклад 'Romero y tomillo'), тобто сумувати по полю quantity
SELECT SUM(OD.Quantity) as [COUNT Name]
FROM Orders O join OrderDetails OD on O.CustomerID = OD.ID AND OD.OrderID=O.ID join Customers C on C.CustomerName='Vehicula Ltd';

--Знайти загальну грошову суму, на яку замовив товарів певний клієнт(в умові
--вказувати назву клієнта, наприклад 'Romero y tomillo')
SELECT SUM(P.Price*OD.Quantity) AS [Sum money]
FROM Products P, OrderDetails OD, Customers C, Orders O
WHERE C.CustomerName = 'Vehicula Ltd' AND C.ID=O.CustomerID AND OD.OrderID=O.ID AND OD.ProductID=P.ID;


--Вивести кількість замовлень по кожному клієнту(показувати імена клієнтів)
SELECT COUNT(*) AS 'COUNT Order', C.CustomerName
FROM Customers C, Orders O
WHERE C.ID=O.CustomerID
GROUP BY C.CustomerName;

--Вивести кількість замовлень по кожному клієнту, здійснені після вказаної дати
SELECT COUNT(*) AS 'COUNT Order', C.CustomerName
FROM Customers C, Orders O
WHERE C.ID=O.CustomerID AND Convert(Nvarchar,(O.OrderDate)) > '2020' --конвертує тип Date в Nvarchar
GROUP BY C.CustomerName;

--Вивести кількість замовлень по кожному року(або місяцю, якщо дати в межах одного року)???
SELECT COUNT(*) AS 'COUNT Order', O.OrderDate
FROM Orders O
WHERE C.ID=O.CustomerID AND Convert(Nvarchar,(O.OrderDate)) > '2020' --конвертує тип Date в Nvarchar
GROUP BY O.OrderDate;

--Вивести кількість замовлень по кожному клієнту, що здійснив більше 5 замовлень
SELECT COUNT(O.ID) AS 'Count Order', O.CustomerID
FROM Orders O join Customers C on O.CustomerID=C.ID
GROUP BY O.CustomerID
HAVING COUNT(O.ID) > 5;

--Вивести кількість товарів по кожному замовленню(sum)
SELECT SUM(OD.Quantity) AS 'Order Quantity', O.ID
FROM Orders O join OrderDetails OD on O.ID=OD.OrderID
GROUP BY O.ID;

--Знайти кількість товарів, які постачаються з кожної країни
SELECT SUM(OD.Quantity) AS 'Order Quantity', C.Country
FROM Customers C join Orders O on C.ID=O.CustomerID join OrderDetails OD on O.ID=OD.OrderID
GROUP BY C.Country;

--Вивести вартість (ціна продукту * кількість продукту) по кожному замовленню(sum)
SELECT SUM(P.Price*OD.Quantity) AS 'Cost Order', O.ID
FROM Products P join OrderDetails OD on P.ID=OD.ProductID join Orders O on O.ID=OD.OrderID
GROUP BY O.ID;