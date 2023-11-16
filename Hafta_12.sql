Create database Hafta_12
--Trigger Ýþlemleri, Hafta 12
--Tablo oluþturalým
CREATE TABLE tbOgrenciler(
ogrno int identity,
isim varchar(10),
bolum varchar(10),
dogtar date,
boy int
)
--Trigger oluþturma
CREATE TRIGGER tr_OgrenciEkle 
ON tbOgrenciler
FOR INSERT
AS
	DECLARE @ad varchar(20)
	Select @ad=(Select isim from inserted) --ýnserted ve deleted sanal tablolarý kullanýlýr
	PRINT @ad+' isimli öðrenci eklenmiþtir'
--çalýþtýrman
insert into tbOgrenciler(isim)values('Hasan')
--Trigger Ornek 1
Create Trigger te_InsertedList
on tbOgrenciler
For Insert
AS
	Select * from inserted
-- ýnsert ekle ve sonra trigger çalýþsýn
Insert tbOgrenciler (isim) values ('veli')
--Trigger Ornek 2 Alter
CREATE trigger tr_DeletedList
ON tbOgrenciler
FOR DELETE
AS
	Select * From tbOgrenciler
--Alter
Alter trigger tr_DeletedList
ON tbOgrenciler
FOR DELETE
AS
	Select * From deleted
--silme yap ve trigger çalýþsýn
Delete From tbOgrenciler  Where ogrno=5
--Ornek 3 UPDATE
CREATE trigger te_DeleteAndInsertedList
On tbOgrenciler
For UPDATE
AS
	Select * From deleted
	Select * From inserted
--Ýþlemler
Select * From tbOgrenciler
Update tbOgrenciler set isim='Murat' Where ogrno=11

--Hafta 12 Sayfa 9 incele

--Trigger Adýnýn Deðiþtirilmesi, Görüntülenmesi, Silinmesi
Sp_rename 'te_DeleteAndInsertedList', 'DeleteVeInsertedList' --- Triggerýn adýný deðiþtirir

Sp_helptext tr_OgrenciEkle --- Varolan triggerýn kodunu görüntüler. (Encryption option               kullanýlmamýþ ise)

Sp_helptrigger tbOgrenciler --- Bir tablo üstündeki triggerlarý listeler

DROP TRIGGER triggeradý --- Belirtilen isimli triggerý siler

--Triggerlarýnaktif pasif yapma
Disable trigger tr_OgrenciEkle ON tbOgrenciler -- Pasif
enable trigger tr_OgrenciEkle ON tbOgrenciler --Aktif
--Yada
Alter table tbOgrenciler
Disable trigger tr_OgrenciEkle
Alter table tbOgrenciler
enable trigger tr_OgrenciEkle;

DISABLE TRIGGER ALL ON tbOgrenciler; -- Tablodaki tüm triggerlari pasif yapar
ENABLE TRIGGER ALL ON tbOgrenciler; --Tablodaki tüm triggerlari aktif yapar


Declare @ulke varchar(10) = 'Turkiye'
Select SUBSTRING(@ulke,4,4) 
















