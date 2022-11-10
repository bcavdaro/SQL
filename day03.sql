--SUBQUERIES
-- Her markanin ismini,calisan sayisini ve  o markaya ait calisanlrin toplam maasini listeleyiniz.
Select *from calisanlar2
Select *from markalar

SELECT marka_isim,calisan_sayisi,
(SELECT sum(maas) from calisanlar2 WHERE marka_isim=isyeri)AS calisanlar_toplam_maas
FROM markalar

--Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.

SELECT marka_isim,calisan_sayisi,
(select max(maas)from calisanlar2 WHERE marka_isim=isyeri) as en_yuksek_maas,
(select min(maas) from calisanlar2 WHERE marka_isim=isyeri) as en_dusuk_maas
From markalar;

CREATE TABLE mart
(
urun_id int,
musteri_isim varchar(50), urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan
(
urun_id int ,
musteri_isim varchar(50), urun_isim varchar(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

--MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
-- URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
-- MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız.

SELECT urun_id, musteri_isim FROM mart
WHERE exists (SELECT urun_id from nisan WHERE mart.urun_id=nisan.urun_id)

--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız

SELECT urun_isim,musteri_isim FROM nisan
WHERE exists (SELECT urun_isim FROM mart WHERE mart.urun_isim=nisan.urun_isim)


--Her iki ayda birden satılmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız

SELECT urun_isim,musteri_isim FROM nisan
WHERE not exists (SELECT urun_isim FROM mart WHERE mart.urun_isim=nisan.urun_isim)

-----UPDATE


CREATE TABLE tedarikciler4
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);

INSERT INTO tedarikciler4 VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler4 VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler4 VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler4 VALUES (104, 'Apple', 'Adam Eve');

CREATE TABLE urunler4
(
ted_vergino int,
urun_id int,
urun_isim VARCHAR(50),
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) REFERENCES tedarikciler4(vergi_no)
on delete cascade
);

INSERT INTO urunler4 VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler4 VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler4 VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler4 VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler4 VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler4 VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler4 VALUES(104, 1007,'Phone', 'Aslan Yılmaz');

SELECT * FROM tedarikciler4

SELECT * FROM urunler4

-- vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.

Update tedarikciler4
set firma_ismi='Vestel'WHERE vergi_no=102;

-- vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve 
--irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.

Update tedarikciler4
set firma_ismi='Casper',irtibat_ismi='Ali Veli' WHERE vergi_no=101;

Select * from tedarikciler4

-- urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.

UPDATE urunler4
SET urun_isim='Telefon'
WHERE urun_isim='Phone'


SELECT * FROM urunler4

-- urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id’sini 1 arttırın.

UPDATE urunler4
SET urun_id = urun_id+1
WHERE urun_id>1004;


-- urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino 
--sutun değerleri ile toplayarak güncelleyiniz.

UPDATE urunler4
SET urun_id=urun_id+ted_vergino

SELECT * FROM urunler4


delete from tedarikciler4
delete from urunler4

SELECT * FROM tedarikciler4
SELECT * FROM urunler4

--urunlr tablosundaki tum urun isimlerin, musteri isimleri ile birlestirerek update edelim.

update urunler4
set urun_isim=concat(urun_isim,'-',musteri_isim)

--Tabloda iki string field'i bir biri ile birlestirmek icin bu yolu kullanabiliriz.
UPDATE urunler4
SET urun_isim= urun_isim|| '-' || musteri_isim



delete from urunler4

SELECT * FROM tedarikciler4
SELECT * FROM urunler4

--urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci tablosunda irtibat_ismi
--'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz.

UPDATE urunler4
SET urun_isim=(SELECT firma_ismi from tedarikciler4 WHERE irtibat_ismi='Adam Eve')
WHERE musteri_isim='Ali Bak'


SELECT * FROM urunler4


--Urunler tablosunda laptop satin alan musterilerin ismini, firma_ismi Apple'in irtibat_ismi
-- iler degistirin.
UPDATE urunler4						
SET musteri_isim = (SELECT irtibat_ismi FROM tedarikciler4 WHERE firma_ismi = 'Apple')						
WHERE urun_isim = 'Laptop'

SELECT * FROM urunler4

--ALLIES
SELECT urun_id AS id, urun_isim AS isim from urunler4

SELECT * FROM urunler4

SELECT urun_id AS id, urun_isim ||' '||musteri_isim AS urun_isim_musteri_isim
from urunler4;


CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50), adres varchar(50)
);

CREATE TABLE insanlar
(
ssn char(9),
name varchar(50), 
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa');
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

DROP table insanlar

----is null condition

SELECT * FROM insanlar WHERE name is null

SELECT * FROM insanlar WHERE name is not null

