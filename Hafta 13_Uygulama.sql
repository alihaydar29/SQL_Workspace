Use Northwind
--2-Customers tablosuna “RegistrationDate” isminde içine sadece tarih girilebilecek, sistem saattarih deðerinden büyük olamayacak ve veri giriþi yapýlmazsa sistem saattarih deðeri otomatik yazýlacak olan bir alan için gerekli SQL kodunu yazýnýz. 
-- column oluþturma
Alter Table Customers
ADD RegistrationDate date
--default ekleme
Alter table Customers
ADD CONSTRAINT def_RegistrationDate
DEFAULT getdate() FOR RegistrationDate
--check kontrol
Alter table Customers
ADD CONSTRAINT ck_RegistrationDate
CHECK (RegistrationDate<getdate())

--Silme Komutlarý
Alter table Customers
Drop constraint ck_RegistrationDate
Alter table Customers
drop constraint def_RegistrationDate
Alter table Customers
Drop column RegistrationDate

--3-Hiç satýþý yapýlmamýþ olan ürünlerin isimleri (Products-ProductName) ve tedarikçilerinin (Suppliers-CompanyName) isimleri listesini “Hic_Satilmayan_Urunler” isimli bir tablo oluþturup içine atacak olan SQL ifadesini yazýnýz. (Select ile tablo oluþturulacaktýr.)
--SELECT sirano, ad INTO ornekyeni FROM ornek WHERE sirano<3 

Select ProductName,CompanyName INTO Hic_Satilmayan_Urunler From Products p inner join Suppliers s ON p.SupplierID=s.SupplierID

--4-Çalýþan personellerin (Employees) doðum günlerinin (Birthdate) aylara göre dökümünü þekildeki gibi veren SQL ifadesini yazýnýz.
Select DATENAME(month,BirthDate) AS Ay_Adý,Count(Birthdate) BuAydaDoganSayýsý From Employees Group by DATENAME(month,BirthDate)

--5-Her sipariþin (OrderID) hangi müþteri (Customers-ContactName) tarafýndan alýndýðý ve hangi kargo þirketiyle (Shippers-CompanyName) gönderileceði dökümünü veren SQL ifadesini yazýnýz.
Select OrderID,ContactName,s.CompanyName From Orders o inner join Customers c ON o.CustomerID=c.CustomerID join  Shippers s ON s.ShipperID=o.ShipVia

--6-En az (sipariþ sayýsý olarak) hangi “ülkedeki” müþteriler (Customers-Country) tarafýndan sipariþ verildiði bilgisini veren SQL ifadesini yazýnýz. (Sadece ülke ismi listelenecektir.) 
Select Country From Customers c inner join Orders o ON c.CustomerID=o.CustomerID group by Country order by Count (Country) desc



