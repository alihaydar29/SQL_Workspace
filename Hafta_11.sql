Create Database Hafta_11
--DECLARE Ýþlemleri
--DECLARE atama iþlemleri
--1.Yol
DECLARE @enphalýurun varchar(10)='PS/2 Klavye'
SELECT @enphalýurun AS Urun
--2.Yol
DECLARE @x int
SET @x=15
SELECT @x AS Sayý
--3.Yol
DECLARE @enYuksekFiyat Money
SELECT @enYuksekFiyat=23754.78
SELECT @enYuksekFiyat AS Fiyat

--DECLARE Tablolu Ornek
--Tablo oluþtur ve veri ekle
CREATE table Personelbilgi(
Perno int identity(1,1),
Ucret Money,
ad varchar(10),
gorev varchar(10)
)
insert Personelbilgi values (500,'Ali','Kaptan'),(700,'Kar','Sofor'),(1000,'Veli','Gemici'),(900,'Su','Sofor'),(700,'Eda','Mudur'),(600,'Mars','Kalýpcý')

--Declare komutlarý En yüksek ücreti bulmak
DECLARE @enYuksekUcret Money
SELECT @enYuksekUcret=MAX(Ucret) FROM Personelbilgi
PRINT @enYuksekUcret
PRINT'EN Yuksek Ucret = '+CAST(@enYuksekUcret as varchar(20))

--Belirli bir personel numaralý kiþinin adý ve görevinin bulunup deðiþkenlere aktarýlmasý ve ekrana yazdýrýlmasý
DECLARE @isim varchar(20), @unvan varchar(20)
SELECT @isim=ad,@unvan=gorev From Personelbilgi Where Perno=5
SELECT @isim,@unvan
SELECT '5 nolu personelin adý= '+@isim,@unvan

--Birleþik Operatörler
DECLARE @sayac int=0
SET @sayac += 7
SELECT @sayac As Arti7
SET @sayac -= 2
SELECT @sayac As Eksi2
SET @sayac *= 10
SELECT @sayac As Çarpý10
SET @sayac /= 5
SELECT @sayac As Bölü5
SET @sayac %= 8
SELECT @sayac As Mod8 

--Tablo Tipi Deðiþken
DECLARE @TabloTipiDegisken TABLE(
numara tinyint identity,
isim varchar(20))

insert into @TabloTipiDegisken values ('Ali')
insert into @TabloTipiDegisken values ('Veli')
--Hepsine seç öyle çalýþtýr
SELECT * FROM @TabloTipiDegisken

--Akýþ Kotrolleri Ýf - else if - esle
--Örnek 1
DECLARE @ornek int = 6
if @ornek <=5
begin
	Print 'Sayý 5 e eþit veya küçüktür'
end
else
begin
	Print 'Sayý 5 den büyüktür'
end
--Örnek 2
DECLARE @ornek int=0
if @ornek<0
begin
	print 'Sayý negatiftir'
end
else if (@ornek>0)
begin 
	print 'Sayý Pozitiftir'
end
else
begin
	print 'Sayý Sýfýrdýr'
end
--Örnek 3
if(Select COUNT(*)From Personelbilgi Where Perno=5 and ad='Eda')>0
begin
	print 'Bu kayýt daha önceden girilmiþtir. Tekrar giremezsiniz'
end
else
Begin
	insert Personelbilgi values (200,'Fatma','Yeni')
end
--Örnek 4
if EXISTS (Select * From Personelbilgi)
	print 'Tanýmlý Personel Vardýr'
Else
	print 'Hiç Personel Yok' 
--Örnek 5
if NOT EXISTS (Select * From Personelbilgi)
begin
	print 'Hiç Personel Yok'
	print 'Ýkinci Satýr'
end
else
begin 
	print 'Tanýmlý Personel Vardýr'
	print 'Else ikinci Satýr'
end

--Case Ýfadesi Ýle Akýþ Kontrolü 
--Örnek 1
Select gorev, COUNT(gorev) AS Görevli_Sayýsý,Yildiz_Gösterimi=Case
When COUNT (gorev)>3 Then '* * * *'
When COUNT (gorev)>2 Then '* * * '
When COUNT (gorev)>1 Then '* * '
When COUNT (gorev)>0 Then '* '
end
From Personelbilgi
Group by gorev
order by Yildiz_Gösterimi

--While Döngüsü *Break, Continue ile özelleþtirilebilir
--Örnek 1
DECLARE @sayac int
Select @sayac=1
While(@sayac<15)
begin
Select @sayac=@sayac+1
Select 'Sayac=',@sayac AS Sayacýn_Son_Deðeri
end
--Örnek 2 Döngü olmadý
Declare @sayac int
Select @sayac=1
While(@sayac<15)
Select @sayac=@sayac+1
Select 'Sayac=',@sayac AS Sayacýn_Son_Deðeri
--Örnek 3
CReate Table deneme(
yazNo tinyint identity,
metin varchar(25)
)
Declare @sayac int=1
While(@sayac<=5)
begin
	insert deneme (metin) values (CAST(@sayac as varchar(5))+'numaralý Düzce eklendi')
	select @sayac=@sayac+1
end
Select * From deneme

--Stored Procedures
--Kullanýlacak tablo oluþturma
CREATE Table tbOgrenci(
ogrno int identity not null,
ad varchar(20) null,
bolum varchar(20) null,
boy tinyint null
)
INSERT tbOgrenci Values ('Ali','MUH',180),('Fatma','EM',170),('Su','BM',175),('Kar','EM',185)
--Sp Oluþturma
CREATE PROC spDisplayAll
AS
	SELECT * FROM tbOgrenci
GO
--Sp Çalýþtýrma
Exec spDisplayAll
Execute spDisplayAll
-- çalýþtýrýlacak kod bloðunun ilk satýrý ise
spDisplayAll 
--Sp Yapýsýný deðiþtirme
ALTER PROC spDisplayAll
AS
	SELECT * From tbOgrenci
	Where ad LIKE 'a%'
GO
--sp_helptext prosedurad: Varolan prosedürün kodunu listeler
sp_helptext spDisplayAll
--Bir sorgu sonucundan kaç kayýt eklendiðinin gösterilmesi mesajý «nocount»un ON edilmesi ile durdurulabilir. 
--Ama sorgudan kaç kayýtýn etkilendiði @@rowcount parametresinde hesaplanmaya devam edilecektir. 
Exec spDisplayAll --- x adet kayýt listeler
Select @@rowcount --- «adet» yazar
Exec spDisplayAll with recompile ---  tekrar compile edilerek çalýþtýr anlamýna gelir. 
--Sp Silmek
DROP PROC spDisplayAll
--SP’lerin Girdi Parametreli Kullanýmý
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
--Tanýmlama satýrýndaki deðiþkenler parantez içerisinde olmasa da kabul edilir.
CREATE Proc spListe(@boy int=175,@bolum varchar(10)='BM')
AS
	SELECT * FROM tbOgrenci
	Where bolum=@bolum and boy=@boy
GO
EXEC spListe --Default deðerlere göre çalýþýr
EXEC spListe 170,'EM'--Verilen deðere göre çalýþýr
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
Exec spGetlist  --- «ad» alaný NULL olanlarýn haricindeki tümü listelenir.
Exec spGetlist 'Fatma' -- «ad»’ý Fatma olanlar listelenir
--SP’lerin Girdi ve Çýktý Parametreli Kullanýmý
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
--*OUTPUT’lar yerine OUT þeklinde de kullanýlabilir.
--OUTPUT Ornek 2
CREATE PROC spHarfsay
	@say int, @adet int OUT
AS
	SELECT @adet=COUNT (*) FROM tbOgrenci
	Where len(ad)=@say
GO
DECLARE @result int
EXEC spHarfsay 5,@result OUT
SELECT @result AS SONUC --ism 5 Harfli kiþilerin sayýsýný yazar
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
--Sp’ler ile Kayýt Ýþlem Örnekleri
--Tabloya kayýt girme
CREATE PROC spInsert
@isim varchar(20),@bolum varchar(10),@boy tinyint
AS
	INSERT tbOgrenci Values (@isim,@bolum,@boy)
GO
EXEC spInsert 'fahri','TM',190
SELECT * FROM tbOgrenci
--Tablodan kayýt silme
CREATE PROC spSilme
	@ogrno int
AS
	DELETE FROM tbOgrenci
	WHERE ogrno=@ogrno
GO
EXEC spSilme 5
SELECT * FROM tbOgrenci
--Tablo kayýt güncelleme
CREATE PROC spupdate
@ogrno int,@ad varchar(20),@bolum varchar(10)
AS
	UPDATE tbOgrenci
	SET ad=@ad,bolum=@bolum
	WHERE
	ogrno=@ogrno
GO
EXEC spupdate 6,'musaaaa','BM'















