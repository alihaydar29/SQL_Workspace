Use Northwind
--2-Customers tablosuna �RegistrationDate� isminde i�ine sadece tarih girilebilecek, sistem saattarih de�erinden b�y�k olamayacak ve veri giri�i yap�lmazsa sistem saattarih de�eri otomatik yaz�lacak olan bir alan i�in gerekli SQL kodunu yaz�n�z. 
-- column olu�turma
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

--Silme Komutlar�
Alter table Customers
Drop constraint ck_RegistrationDate
Alter table Customers
drop constraint def_RegistrationDate
Alter table Customers
Drop column RegistrationDate

--3-Hi� sat��� yap�lmam�� olan �r�nlerin isimleri (Products-ProductName) ve tedarik�ilerinin (Suppliers-CompanyName) isimleri listesini �Hic_Satilmayan_Urunler� isimli bir tablo olu�turup i�ine atacak olan SQL ifadesini yaz�n�z. (Select ile tablo olu�turulacakt�r.)
--SELECT sirano, ad INTO ornekyeni FROM ornek WHERE sirano<3 

Select ProductName,CompanyName INTO Hic_Satilmayan_Urunler From Products p inner join Suppliers s ON p.SupplierID=s.SupplierID

--4-�al��an personellerin (Employees) do�um g�nlerinin (Birthdate) aylara g�re d�k�m�n� �ekildeki gibi veren SQL ifadesini yaz�n�z.
Select DATENAME(month,BirthDate) AS Ay_Ad�,Count(Birthdate) BuAydaDoganSay�s� From Employees Group by DATENAME(month,BirthDate)

--5-Her sipari�in (OrderID) hangi m��teri (Customers-ContactName) taraf�ndan al�nd��� ve hangi kargo �irketiyle (Shippers-CompanyName) g�nderilece�i d�k�m�n� veren SQL ifadesini yaz�n�z.
Select OrderID,ContactName,s.CompanyName From Orders o inner join Customers c ON o.CustomerID=c.CustomerID join  Shippers s ON s.ShipperID=o.ShipVia

--6-En az (sipari� say�s� olarak) hangi ��lkedeki� m��teriler (Customers-Country) taraf�ndan sipari� verildi�i bilgisini veren SQL ifadesini yaz�n�z. (Sadece �lke ismi listelenecektir.) 
Select Country From Customers c inner join Orders o ON c.CustomerID=o.CustomerID group by Country order by Count (Country) desc



