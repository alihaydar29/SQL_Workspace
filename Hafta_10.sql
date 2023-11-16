Create Database Hafta_10
--Tablo oluþtur => Örnek 1
Create table IndexOrnek(
kayitno bigint identity,
isim varchar(20)
)
--Ýþlem
Declare @i int =1
Declare @isim varchar(10)='Duzce'
While @i<100000
begin
	insert IndexOrnek
	select @isim+'-'+CAST(@i as varchar(10))
	set @i=@i+1
end

--truncate table IndexOrnek
--Select COUNT(*) From IndexOrnek
SET STATISTICS IO ON
SET STATISTICS TIME ON
Select * From IndexOrnek where kayitno=75500

--Tablo oluþtur => Örnek 2
Create table IndexOrnek2(
kayitno bigint identity,
isim varchar(20)
)
Create Clustered Index IN_IndexOrnek2 ON IndexOrnek2 (kayitno)
--Ýþlem
Declare @i int =1
Declare @isim varchar(10)='Duzce'
While @i<100000
begin
	insert IndexOrnek2
	select @isim+'-'+CAST(@i as varchar(10))
	set @i=@i+1
end

SET STATISTICS IO ON
SET STATISTICS TIME ON

Select * From IndexOrnek2 where kayitno=75500

--truncate table IndexOrnek2
--Select COUNT(*) From IndexOrnek2

--View Konusunu Ayrýca çalýþ

create table tbSube1 (
Subekod tinyint not null,
Urunkod int,
Urunad varchar(50),
Check (subekod=1)
)
Create table tbSube2 (
Subekod tinyint not null,
Urunkod int,
Urunad varchar(50),
Check (subekod=2)
)
drop table tbSube1,tbSube2

CREATE VIEW vw_TumSubeler
AS
  SELECT * FROM tbSube1
  UNION ALL
  SELECT * FROM tbSube2

SELECT * FROM vw_TumSubeler

Insert into vw_TumSubeler (subekod, urunkod, urunad) Values (1,4, 'Defter'), (2,4, 'Kitap'), (2,5,'Cetvel')














