Create database Hafta_12
--Trigger ��lemleri, Hafta 12
--Tablo olu�tural�m
CREATE TABLE tbOgrenciler(
ogrno int identity,
isim varchar(10),
bolum varchar(10),
dogtar date,
boy int
)
--Trigger olu�turma
CREATE TRIGGER tr_OgrenciEkle 
ON tbOgrenciler
FOR INSERT
AS
	DECLARE @ad varchar(20)
	Select @ad=(Select isim from inserted) --�nserted ve deleted sanal tablolar� kullan�l�r
	PRINT @ad+' isimli ��renci eklenmi�tir'
--�al��t�rman
insert into tbOgrenciler(isim)values('Hasan')
--Trigger Ornek 1
Create Trigger te_InsertedList
on tbOgrenciler
For Insert
AS
	Select * from inserted
-- �nsert ekle ve sonra trigger �al��s�n
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
--silme yap ve trigger �al��s�n
Delete From tbOgrenciler  Where ogrno=5
--Ornek 3 UPDATE
CREATE trigger te_DeleteAndInsertedList
On tbOgrenciler
For UPDATE
AS
	Select * From deleted
	Select * From inserted
--��lemler
Select * From tbOgrenciler
Update tbOgrenciler set isim='Murat' Where ogrno=11

--Hafta 12 Sayfa 9 incele

--Trigger Ad�n�n De�i�tirilmesi, G�r�nt�lenmesi, Silinmesi
Sp_rename 'te_DeleteAndInsertedList', 'DeleteVeInsertedList' --- Trigger�n ad�n� de�i�tirir

Sp_helptext tr_OgrenciEkle --- Varolan trigger�n kodunu g�r�nt�ler. (Encryption option               kullan�lmam�� ise)

Sp_helptrigger tbOgrenciler --- Bir tablo �st�ndeki triggerlar� listeler

DROP TRIGGER triggerad� --- Belirtilen isimli trigger� siler

--Triggerlar�naktif pasif yapma
Disable trigger tr_OgrenciEkle ON tbOgrenciler -- Pasif
enable trigger tr_OgrenciEkle ON tbOgrenciler --Aktif
--Yada
Alter table tbOgrenciler
Disable trigger tr_OgrenciEkle
Alter table tbOgrenciler
enable trigger tr_OgrenciEkle;

DISABLE TRIGGER ALL ON tbOgrenciler; -- Tablodaki t�m triggerlari pasif yapar
ENABLE TRIGGER ALL ON tbOgrenciler; --Tablodaki t�m triggerlari aktif yapar


Declare @ulke varchar(10) = 'Turkiye'
Select SUBSTRING(@ulke,4,4) 
















