Create Database Hafta_11
--DECLARE ��lemleri
--DECLARE atama i�lemleri
--1.Yol
DECLARE @enphal�urun varchar(10)='PS/2 Klavye'
SELECT @enphal�urun AS Urun
--2.Yol
DECLARE @x int
SET @x=15
SELECT @x AS Say�
--3.Yol
DECLARE @enYuksekFiyat Money
SELECT @enYuksekFiyat=23754.78
SELECT @enYuksekFiyat AS Fiyat

--DECLARE Tablolu Ornek
--Tablo olu�tur ve veri ekle
CREATE table Personelbilgi(
Perno int identity(1,1),
Ucret Money,
ad varchar(10),
gorev varchar(10)
)
insert Personelbilgi values (500,'Ali','Kaptan'),(700,'Kar','Sofor'),(1000,'Veli','Gemici'),(900,'Su','Sofor'),(700,'Eda','Mudur'),(600,'Mars','Kal�pc�')

--Declare komutlar� En y�ksek �creti bulmak
DECLARE @enYuksekUcret Money
SELECT @enYuksekUcret=MAX(Ucret) FROM Personelbilgi
PRINT @enYuksekUcret
PRINT'EN Yuksek Ucret = '+CAST(@enYuksekUcret as varchar(20))

--Belirli bir personel numaral� ki�inin ad� ve g�revinin bulunup de�i�kenlere aktar�lmas� ve ekrana yazd�r�lmas�
DECLARE @isim varchar(20), @unvan varchar(20)
SELECT @isim=ad,@unvan=gorev From Personelbilgi Where Perno=5
SELECT @isim,@unvan
SELECT '5 nolu personelin ad�= '+@isim,@unvan

--Birle�ik Operat�rler
DECLARE @sayac int=0
SET @sayac += 7
SELECT @sayac As Arti7
SET @sayac -= 2
SELECT @sayac As Eksi2
SET @sayac *= 10
SELECT @sayac As �arp�10
SET @sayac /= 5
SELECT @sayac As B�l�5
SET @sayac %= 8
SELECT @sayac As Mod8 

--Tablo Tipi De�i�ken
DECLARE @TabloTipiDegisken TABLE(
numara tinyint identity,
isim varchar(20))

insert into @TabloTipiDegisken values ('Ali')
insert into @TabloTipiDegisken values ('Veli')
--Hepsine se� �yle �al��t�r
SELECT * FROM @TabloTipiDegisken

--Ak�� Kotrolleri �f - else if - esle
--�rnek 1
DECLARE @ornek int = 6
if @ornek <=5
begin
	Print 'Say� 5 e e�it veya k���kt�r'
end
else
begin
	Print 'Say� 5 den b�y�kt�r'
end
--�rnek 2
DECLARE @ornek int=0
if @ornek<0
begin
	print 'Say� negatiftir'
end
else if (@ornek>0)
begin 
	print 'Say� Pozitiftir'
end
else
begin
	print 'Say� S�f�rd�r'
end
--�rnek 3
if(Select COUNT(*)From Personelbilgi Where Perno=5 and ad='Eda')>0
begin
	print 'Bu kay�t daha �nceden girilmi�tir. Tekrar giremezsiniz'
end
else
Begin
	insert Personelbilgi values (200,'Fatma','Yeni')
end
--�rnek 4
if EXISTS (Select * From Personelbilgi)
	print 'Tan�ml� Personel Vard�r'
Else
	print 'Hi� Personel Yok' 
--�rnek 5
if NOT EXISTS (Select * From Personelbilgi)
begin
	print 'Hi� Personel Yok'
	print '�kinci Sat�r'
end
else
begin 
	print 'Tan�ml� Personel Vard�r'
	print 'Else ikinci Sat�r'
end

--Case �fadesi �le Ak�� Kontrol� 
--�rnek 1
Select gorev, COUNT(gorev) AS G�revli_Say�s�,Yildiz_G�sterimi=Case
When COUNT (gorev)>3 Then '* * * *'
When COUNT (gorev)>2 Then '* * * '
When COUNT (gorev)>1 Then '* * '
When COUNT (gorev)>0 Then '* '
end
From Personelbilgi
Group by gorev
order by Yildiz_G�sterimi

--While D�ng�s� *Break, Continue ile �zelle�tirilebilir
--�rnek 1
DECLARE @sayac int
Select @sayac=1
While(@sayac<15)
begin
Select @sayac=@sayac+1
Select 'Sayac=',@sayac AS Sayac�n_Son_De�eri
end
--�rnek 2 D�ng� olmad�
Declare @sayac int
Select @sayac=1
While(@sayac<15)
Select @sayac=@sayac+1
Select 'Sayac=',@sayac AS Sayac�n_Son_De�eri
--�rnek 3
CReate Table deneme(
yazNo tinyint identity,
metin varchar(25)
)
Declare @sayac int=1
While(@sayac<=5)
begin
	insert deneme (metin) values (CAST(@sayac as varchar(5))+'numaral� D�zce eklendi')
	select @sayac=@sayac+1
end
Select * From deneme

--Stored Procedures
--Kullan�lacak tablo olu�turma
CREATE Table tbOgrenci(
ogrno int identity not null,
ad varchar(20) null,
bolum varchar(20) null,
boy tinyint null
)
INSERT tbOgrenci Values ('Ali','MUH',180),('Fatma','EM',170),('Su','BM',175),('Kar','EM',185)
--Sp Olu�turma
CREATE PROC spDisplayAll
AS
	SELECT * FROM tbOgrenci
GO
--Sp �al��t�rma
Exec spDisplayAll
Execute spDisplayAll
-- �al��t�r�lacak kod blo�unun ilk sat�r� ise
spDisplayAll 
--Sp Yap�s�n� de�i�tirme
ALTER PROC spDisplayAll
AS
	SELECT * From tbOgrenci
	Where ad LIKE 'a%'
GO
--sp_helptext prosedurad: Varolan prosed�r�n kodunu listeler
sp_helptext spDisplayAll
--Bir sorgu sonucundan ka� kay�t eklendi�inin g�sterilmesi mesaj� �nocount�un ON edilmesi ile durdurulabilir. 
--Ama sorgudan ka� kay�t�n etkilendi�i @@rowcount parametresinde hesaplanmaya devam edilecektir. 
Exec spDisplayAll --- x adet kay�t listeler
Select @@rowcount --- �adet� yazar
Exec spDisplayAll with recompile ---  tekrar compile edilerek �al��t�r anlam�na gelir. 
--Sp Silmek
DROP PROC spDisplayAll
--SP�lerin Girdi Parametreli Kullan�m�
--Ornek 1
CREATE PROC spDisplayParam1
	@isim varchar(10)
AS
	Select * From tbOgrenci
	Where ad=@isim
GO
EXEC spDisplayParam1 @isim='Can'
EXEC spDisplayParam1 'Can'
--Ornek 2
CREATE PROC spParam2
	@harf varchar(1), @boy int
AS
	SELECT * From tbOgrenci
	Where ad LIKE @harf+'%'AND boy>@boy

spParam2 'f',150
EXEC spParam2 'f',150
EXEC spParam2 @harf='f', @boy=150
--Ornek 3
--Tan�mlama sat�r�ndaki de�i�kenler parantez i�erisinde olmasa da kabul edilir.
CREATE Proc spListe(@boy int=175,@bolum varchar(10)='BM')
AS
	SELECT * FROM tbOgrenci
	Where bolum=@bolum and boy=@boy
GO
EXEC spListe --Default de�erlere g�re �al���r
EXEC spListe 170,'EM'--Verilen de�ere g�re �al���r
--Ornek 4
ALTER PROC spListe @boy int=175,@bolum varchar(10)=NULL
AS
	SELECT * FROM tbOgrenci
	Where bolum=@bolum OR boy=@boy
GO
Exec spListe 170,'EM'
Exec spListe 170
Exec spListe NULL,'EM'
Exec spListe 170,NULL
--Ornek 5
CREATE PROC spGetList
	@ad varchar(15)=NULL
AS
	SELECT * FROM tbOgrenci
	WHERE ad=ISNULL(@ad,ad)
GO
Exec spGetlist  --- �ad� alan� NULL olanlar�n haricindeki t�m� listelenir.
Exec spGetlist 'Fatma' -- �ad��� Fatma olanlar listelenir
--SP�lerin Girdi ve ��kt� Parametreli Kullan�m�
--OUTPUT Ornek
CREATE PROC spToplam
	@bir int, @iki int, @toplam int OUTPUT
AS
	SELECT @toplam=@bir+@iki
GO
DECLARE @sonuc int
Exec spToplam 3,5,@sonuc Output
Select @sonuc int
Select 'Sonucumuz ='+CAST(@sonuc as varchar(16))as TOPLAMSONUCU
--*OUTPUT�lar yerine OUT �eklinde de kullan�labilir.
--OUTPUT Ornek 2
CREATE PROC spHarfsay
	@say int, @adet int OUT
AS
	SELECT @adet=COUNT (*) FROM tbOgrenci
	Where len(ad)=@say
GO
DECLARE @result int
EXEC spHarfsay 5,@result OUT
SELECT @result AS SONUC --ism 5 Harfli ki�ilerin say�s�n� yazar
-- return Ornek
CREATE PROC Harfsay2
	@say int=4
AS
	DECLARE @donecek int
	SELECT @donecek=COUNT(*)FROM tbOgrenci
	Where len(ad)=@say
	Return @donecek
GO
DECLARE @sonuc int
EXEC @sonuc=Harfsay2 5
SELECT @sonuc
--Sp�ler ile Kay�t ��lem �rnekleri
--Tabloya kay�t girme
CREATE PROC spInsert
@isim varchar(20),@bolum varchar(10),@boy tinyint
AS
	INSERT tbOgrenci Values (@isim,@bolum,@boy)
GO
EXEC spInsert 'fahri','TM',190
SELECT * FROM tbOgrenci
--Tablodan kay�t silme
CREATE PROC spSilme
	@ogrno int
AS
	DELETE FROM tbOgrenci
	WHERE ogrno=@ogrno
GO
EXEC spSilme 5
SELECT * FROM tbOgrenci
--Tablo kay�t g�ncelleme
CREATE PROC spupdate
@ogrno int,@ad varchar(20),@bolum varchar(10)
AS
	UPDATE tbOgrenci
	SET ad=@ad,bolum=@bolum
	WHERE
	ogrno=@ogrno
GO
EXEC spupdate 6,'musaaaa','BM'















