--use Northwind

--SELECT COUNT(*) [Calisan Sayisi]
--FROM dbo.Employees;

--select *from Products

-- select productName,Unitprice,UnitsInStock from Products

-- select CustomerID,EmployeeID from Orders

--select top 10 ProductName,UnitPrice,UnitsInStock from Products

--select ProductId,SupplierID,CategoryID,UnitPrice from Products where ProductID= 12

--select *from Products where ProductID in (12,25,27,51)

--select*from Products where SupplierID>20 and SupplierID<10

--select*from Products where UnitsInStock between 50 and 100

--select *from Categories where CategoryID in (1,2)

--select *from Products where ProductName like 'a%'

--select*from Products where ProductName like '%a%'

--select*from Products where ProductName like '[ab]%'

--select *from Products where ProductName like '[a-h]%'

--select *from Products where ProductName like '%a' and (UnitPrice between 10and 40)

--select distinct  productID,ProductName from Products

--select *from Products order by UnitPrice asc

--select *from Products where UnitsInStock>50 and CategoryID in (1,2,3) order by UnitPrice desc 

--select *from Products where CategoryID not in (1,2,3)

--select *from products where ProductName not like 'a%'

--select COUNT(ProductName)  from Products

--select COUNT(*) from Products where UnitPrice>50

 --select SUM(UnitsInStock) from Products

 select Sum(UnitPrice*UnitsInStock) from Products