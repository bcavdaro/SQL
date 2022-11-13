
--ORDER BY KOMUTU

CREATE TABLE insanlar2
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),
adres varchar(50)
);

INSERT INTO insanlar2 VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar2 VALUES(234567890, 'Veli','Cem', 'Ankara');
INSERT INTO insanlar2 VALUES(345678901, 'Mine','Bulut', 'Ankara');
INSERT INTO insanlar2 VALUES(256789012, 'Mahmut','Bulut', 'Istanbul');
INSERT INTO insanlar2 VALUES (344678901, 'Mine','Yasa', 'Ankara');
INSERT INTO insanlar2 VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

--INSANLAR TABLOSUNDAKI DATALARI ADRESE GORE SIRALA

SELECT * FROM insanlar2
ORDER BY adres;

-- Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin

select *from insanlar2
where isim='Mine'
order by ssn;

-- Insanlar tablosundaki soyismi Bulut olanlari adres sirali olarak listeleyin
SELECT * FROM insanlar2
WHERE soyisim='Bulut'
ORDER BY 2; -- Sıralamada field numarası da kullanabiliriz

--Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
-- ascending (asc) dogal sirialama kucukten buyuge
--- descending (desc) buyukten kucuge

select *from insanlar2
order by ssn desc;

--insanlar tablosundki tum kayitlaru isimler Natural sirali, 
---soyisimler ters sirali olarak listeleyin

select *from insanlar2
order by isim asc,soyisim desc;

---Yukarida ilk sarti uyguluyour sonra ikinci sarti uyguluyour

-- İsim ve soyisim değerlerini isim soyisim kelime uzunluklarına göre sıralayınız

select isim,soyisim from insanlar2
order by length(isim)

-- Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız

SELECT CONCAT (isim,' ',soyisim) AS isim_soyisim FROM insanlar2
ORDER BY LENGTH(isim)+LENGTH(soyisim)

-- ikinci Yol
SELECT isim||' '||soyisim AS isim_soyisim FROM insanlar2
ORDER BY LENGTH(isim||soyisim)

CREATE TABLE manav
(
isim varchar(50), Urun_adi varchar(50), Urun_miktar int
);

INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);


select * from manav 
---Isme gore alinan toplam urunleri bulun

select isim, sum(urun_miktar) as urun_miktari from manav
group by isim
order by urun_miktari desc


2) Urun ismine gore urunu alan toplam kisi sayisi

select urun_adi, count(isim) from manav
group by urun_adi

3) alinan kilo miktarina gore musteri sayisi

select urun_miktar, count(isim) as Urun_Miktarini_Alan_Kisi_Sayisi
from manav
group by urun_miktar;

CREATE TABLE personel5
(
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20)
);
INSERT INTO personel5 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel5 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO personel5 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel5 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO personel5 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel5 VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO personel5 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

select * from personel5
--isme gore toplam maaslari bulun
select isim, sum(maas)from personel5
group by isim

--sehre gore toplam personel sayisini bulunuz.

select sehir, count(isim) as calisan_sayisi from personel5
group by sehir

-- Sirketlere gore maasi 5000 liradan fazla olan personel sayisini bulun
* hersey demek

SELECT sirket, COUNT(*) as calisan_sayisi FROM personel5
WHERE maas>5000
GROUP BY sirket;


--Her sirket icin Min ve max maaasi bulunr

select sirket, min(maas)as en_dusuk_maas, max(maas) as en_yuksek_maas from personel5
group by sirket

--HAVING KOMUTU  (HAVING GROUP BY ILE KULLANILIR)
--Her sirketin MIN	maaslarini eger 3500’den buyukse goster

SELECT sirket,min(maas) as en_dusuk_maas FROM personel5
GROUP BY sirket
HAVING min(maas)>3500(BURADA ONCE MIN ALIYOUR SONRA 3500 BUYUK OLANLARI ALIYOUR)

-- 2)Ayni isimdeki kisilerin aldigi toplam gelir 
---10000 liradan fazla ise ismi ve toplam maasi gosteren sorgu yaziniz

SELECT isim, sum(maas) as toplam_maas from personel5
group by isim
having sum(maas)>10000;

-- eger bir sehirde calisan personel sayisi 1'den coksa sehir ismini ve personel sayisini
-- veren sorgu yazinz.

select sehir, count(isim)as toplam_personel_sayisi
from personel5
group by sehir
having count (isim)>1;



