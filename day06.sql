--LEFT JOIN
--Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler LEFT JOIN siparisler
ON sirketler.sirket_id = siparisler.sirket_id

SELECT * from sirketler
SELECT * from siparisler

--RIGHT JOIN
--Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler RIGHT JOIN siparisler
ON sirketler.sirket_id = siparisler.sirket_id

--FULL JOIN
--Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler FULL JOIN siparisler
ON sirketler.sirket_id = siparisler.sirket_id

--SElF JOIN

CREATE TABLE personel8 (
id int,
isim varchar(20),
title varchar(60), yonetici_id int
);

INSERT INTO personel8 VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel8 VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel8 VALUES(3, 'Ayse Gul', 'QA Lead', 4);
INSERT INTO personel8 VALUES(4, 'Fatma Can', 'CEO', 5);

SELECT * FROM personel8

-- Her personelin yanina yonetici ismini yazdiran bir tablo olusturun.

select p1.isim as personel_isim, p2.isim as yonetici_isim
from personel8 p1 inner join personel8 p2
on p1.yonetici_id=p2.id

--LIKE CONDITION

CREATE TABLE musteriler2 (
id int UNIQUE,
isim varchar(50) NOT NULL,
gelir int
);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1001, 'Ali', 62000); 
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1002, 'Ayse', 57500);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1004, 'Fatma', 42000);
INSERT INTO musteriler2 (id, isim, gelir) VALUES (1005, 'Kasim', 44000);

--SORU	: Ismi A harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler2 where isim like 'A%';

--Eger buyuk kcucuk har farketmeksizin sorgulama yapmak isterseniz -ilike- kullanabilirsiniz.
SELECT * FROM musteriler2 where isim ilike 'a%';

--like kullanimi 2. yol
--like kullanimi yerinie ~~ bu sembolleri kuallanabilirsiniz.

select * from musteriler2 where isim ~~'A%';

-- like kullaniminda sembol kullaniyoursak ve buyuk kucuk harf gozetmeksiizn sorgu yapmak
-- istersek ~~* sembollerini kullanabiliriz.

select * from musteriler2 where isim ~~*'a%';

--ismi e harfi ile biten musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin

select isim, gelir from musteriler2 where isim like '%e'
select isim, gelir from musteriler2 where isim ilike '%e'

--Isminin icinde er olan musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin

select isim, gelir from musteriler2 where isim ~~* '%er%';

--- Ismi 5 harfli olup son 4 harfi atma olan musterilerin tum bilgilerini yazdiran QUERY yazin
select * from musteriler2 where isim like'_atma';

--- Ikinci harfi a olan musterilerin tum bilgilerini yazdiran QUERY yazin
select * from musteriler2 where isim like'_a%';

--- Ucuncu harfi s olan musterilerin tum bilgilerini yazdiran QUERY yazin

select * from musteriler2 where isim ~~'__s%';

-- Ucuncu harfi s olan ismi 4 harfli musterilerin tum bilgilerini yazdiran QUERY yazin
select * from musteriler2 where isim like'__s_';

-- Ilk harfi F olan en az 4 harfli musterilerin tum bilgilerini yazdiran QUERY yazin
select * from musteriler2 where isim like'F___%';

--- Ikinci harfi a,4.harfi m olan musterilerin tum bilgilerini yazdiran QUERY yazin
select * from musteriler2 where isim like'_a_m%';

----REGEXP_LIKE

CREATE TABLE kelimeler (
id int UNIQUE,
kelime varchar(50) NOT NULL, Harf_sayisi int
);

INSERT INTO kelimeler VALUES (1001, 'hot', 3); 
INSERT INTO kelimeler VALUES (1002, 'hat', 3); 
INSERT INTO kelimeler VALUES (1003, 'hit', 3); 
INSERT INTO kelimeler VALUES (1004, 'hbt', 3); 
INSERT INTO kelimeler VALUES (1008, 'hct', 3); 
INSERT INTO kelimeler VALUES (1005, 'adem', 4);
INSERT INTO kelimeler VALUES (1006, 'selim', 5); 
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);

--- Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin 
---tum bilgilerini  yazdiran

SELECT * FROM Kelimeler where kelime ~'h[ai]t';

-- Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan 3 harfli kelimelerin 
--tum bilgilerini  yazdiran QUERY yazin

select * from kelimeler where kelime ~'h[a-k]t';

-- Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime ~'[mi]';

--- a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime ~'^[as]'; 
---Regexp - like kullaniminda  baslangic icin ^ bitis icin $ semboller kullanilir.

--m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime ~'[mf]$'; 

--Regexp-Like kullanımında sonuç belirtmek için $ sembol kullanılır

---ilk harfi h olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime not like'h%'; 
select * from kelimeler where kelime !~~'h%'; --bu 2.yontem

-- a harfi icermeyen kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime not like'%a%'; 

-- ikinci ve ucuncu harfi ‘de’ olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime not like'_de%'; 

-- 2. harfi e,i veya o olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime !~'[_eio]'; 


CREATE TABLE musteri_urun
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal');
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal');
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma');
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut');
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma');
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal');
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi');
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

---UPPER, LOWER, INITCAP

SELECT UPPER(kelime) as kelime FROM kelimeler
SELECT LOWER(kelime) as kelime FROM kelimeler
SELECT INITCAP(kelime) as kelime FROM kelimeler


---DISTINCT KULLANIMI

CREATE TABLE musteri_urun2
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO musteri_urun2 VALUES (10, 'Ali', 'Portakal');
INSERT INTO musteri_urun2 VALUES (10, 'Ali', 'Portakal');
INSERT INTO musteri_urun2 VALUES (20, 'Veli', 'Elma');
INSERT INTO musteri_urun2 VALUES (30, 'Ayse', 'Armut');
INSERT INTO musteri_urun2 VALUES (20, 'Ali', 'Elma');
INSERT INTO musteri_urun2 VALUES (10, 'Adem', 'Portakal');
INSERT INTO musteri_urun2 VALUES (40, 'Veli', 'Kaysi');
INSERT INTO musteri_urun2 VALUES (20, 'Elif', 'Elma');

SELECT  * fROM musteri_urun2

-- Urun isimlerini distinct komutuyla gruplayalım
select DISTINCT urun_isim from musteri_urun2


-- Musteri isimlerini gruplayınız
select distinct musteri_isim from musteri_urun2

-- Tabloda kac farklı çeşit meyve vardır
SELECT COUNT (distinct (urun_isim)) as meyve_sayisi from musteri_urun2






