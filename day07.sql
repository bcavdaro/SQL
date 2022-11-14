---FETCH NEXT (SAYI) ROW ONLY - OFFSET Kullanimi

select * from musteri_urun2

--Sirali tablodan ilk 3 kaydi listeleyin

SELECT * FROM musteri_urun2
ORDER BY urun_id
FETCH NEXT 3 ROW ONLY

--Sirali tablodan 4. kayittan 7.kayida kadar olan kayitlari listeleyin

SELECT * FROM musteri_urun2
ORDER BY urun_id
OFFSET 3 ROW -- 3 satır atla
FETCH NEXT 4 ROW ONLY -- Sonra 4 satırı getir


----ALTER TABLE -- TABLODAKI SUTUN EKLEME FIELD DAKI VERI TIPINI DEGISTIRME, TABLO ADINI
---DEGISTIRME GIBI TABLODAKI GUNCELLEME ISLEMLERI ICIN KULALNILAIR

CREATE TABLE personel (
id int,
isim varchar(50), sehir varchar(50), maas int,
sirket varchar(20)

);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas'); 
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford'); 
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

DROP TABLE IF exists personel --EGER TABLO VARSA SILER

SELECT * FROM personel

--1 ADD default deger ile tabloya bir field ekleme

ALTER TABLE personel
ADD ulke_ismi varchar(20)

---DEFAULT deger olarak atama yapmak
ALTER TABLE personel
ADD sehir_ismi varchar(20) DEFAULT 'Istanbul'

-- Tabloya birden fazla field ekleme
ALTER TABLE personel
ADD gender char(1), ADD  okul varchar(10);

SELECT * FROM personel

--Drop tablodan sutun silme
ALTER TABLE personel
DROP column okul

-- RENAME COLUMN SUTUN ADI DEGISTIRME

ALTER TABLE personel
RENAME COLUMN ulke_ismi TO ulke_adi

select * from personel

--drop sutun delete degeri siler

--RENAME TABLONUN ISMINI DEGISTIRME

ALTER TABLE personel
rename to isciler

--RENAME tablonun ismini degistirme
ALTER TABLE personel
RENAME TO isciler


--TYPE/SET sutunlarin ozelliklerini degistirme

ALTER TABLE isciler
ALTER COLUMN sehir_ismi TYPE varchar(50)

select * from isciler

ALTER TABLE isciler
ALTER COLUMN sirket SET NOT NULL

--String bir data tipini int. yapmak için bu şekilde kullanırız
ALTER TABLE isciler
ALTER COLUMN ulke_adi TYPE int USING(ulke_adi::int) 


---TRANSACTION (Begin - Savepoint - rollback  -  commit)

CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real
);


BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);

savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);

savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);

ROLLBACK to y;
COMMIT;

--serial data turu kullanimi
insert into ogrenciler2 (isim,veli_isim,yazili_notu) values('erol','ahmet', 95.5)
insert into ogrenciler2 (isim,veli_isim,yazili_notu) values ('evren','cemil',85.5)
Select * From ogrenciler2

---SORULAR

CREATE TABLE isciler2
(
id int,
isim varchar(50),
soyisim varchar (50),
email varchar(50),
ise_baslama_tarih date,
is_unvan varchar (15),
maas int
);

select * from isciler2

insert into isciler2 values (123456789, 'Ali', 'Can', 'alican@gmail.com', '10-APR-10', 'isci', 5000);
insert into isciler2 values (123456788, 'Veli', 'Cem', 'velicem@gmail.com', '10-JAN-12','isci', 5500);
insert into isciler2 values (123456787, 'Ayse', 'Gul', 'aysegul@gmail.com', '01-MAY-14', 'muhasebeci', 4500);
insert into  isciler2 values (123456789, 'Fatma', 'Yasa', 'fatmayasa@gmail.com', '10-APR-09', 'muhendis', 7500);

/*
aYukarda verilen “personel” tablosunu olusturun
b)Tablodan maasi 5000’den az veya unvani isci olanlarin isimlerini listeleyin
c)Iscilerin tum bilgilerini listeleyin
d)Soyadi Can,Cem veya Gul olanlarin unvanlarini ve maaslarini listeleyin
e)Maasi 5000’den cok olanlarin emailve is baslama tarihlerini listeleyin
f)Maasi 5000’den cok veya 7000’den az olanlarin tum bilgilerini listeleyin

*/
--b)Tablodan maasi 5000’den az veya unvani isci olanlarin isimlerini listeleyin
select isim,is_unvan,maas from isciler2
where maas<5000 or is_unvan='isci'

--Iscilerin tum bilgilerini listeleyin
select * from isciler2

--Soyadi Can,Cem veya Gul olanlarin unvanlarini ve maaslarini listeleyin
select soyisim, is_unvan,maas from isciler2
where soyisim in('Can','Cem','Gul')

---Maasi 5000’den cok olanlarin emailve is baslama tarihlerini listeleyin
select email,ise_baslama_tarih,maas from isciler2
where maas>5000

--Maasi 5000’den cok veya 7000’den az olanlarin tum bilgilerini listeleyin
select * From isciler2 where maas between 5000 and 7000

-------SORULAR
drop table personel
CREATE TABLE personel (
id int,
isim varchar(50), sehir varchar(50), maas int,
sirket varchar(20)
);


INSERT INTO personel VALUES(123456789, 'Johnny Walk', 'New Hampshire', 2500, 'IBM');
INSERT INTO personel VALUES(234567891, 'Brian Pitt', 'Florida', 1500, 'LINUX');
INSERT INTO personel VALUES(245678901, 'Eddie Murphy', 'Texas', 3000, 'WELLS FARGO');
INSERT INTO personel VALUES(456789012, 'Teddy Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO personel VALUES(567890124, 'Eddie Murphy', 'Massachuset', 7000, 'MICROSOFT'); 
INSERT INTO personel VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'TD BANK');
INSERT INTO personel VALUES(123456719, 'Adem Stone', 'New Jersey', 2500, 'IBM');

CREATE TABLE isciler3
(
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20)
);

INSERT INTO isciler3 VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO isciler3 VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE'); 
INSERT INTO isciler3 VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO isciler3 VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE'); 
INSERT INTO isciler3 VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT'); 
INSERT INTO isciler3 VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO isciler3 VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

select * from personel
select * from isciler3


---Her iki tablodaki ortak id’leri ve personel tablosunda
--bu id’ye sahip isimleri listeleyen query yaziniz

select isim, id
from personel
where id in (select id from isciler3 where isciler3.id=personel.id)

--Her iki tablodaki ortak id’leri ve isme sahip kayitlari listeleyen query yaziniz.

select id, isim from personel
intersect
select id, isim from isciler3

--Personel tablosunda id’si cift sayi olan personel’in tum bilgilerini listeleyen Query yaziniz

select * from personel
where mod(id,2)=0

---Isciler tablosunda en yuksek maasi alan kisinin tum bilgilerini gosteren query yazin.

select * from isciler3 order by maas desc fetch next 1 row  only 

--2. yol

select max(maas) as max_maas from isciler

ayni sorudan farkli bir soru

select * from isciler
where maas in (select max(maas)from isciler)

--isciler tablosunda en dusuk maasi alan kisinin tum bilgilerini gosteren query yazin.

select * from isciler3 order by maas fetch next 1 row only


--isciler tablosunda ikinci en yuksek maasi gosteren query yazin

select * from isciler3
order by maas desc offset 1 row fetch next 1 row only
