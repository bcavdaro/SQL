--CREATE--Tbalo olusturma
CREATE TABLE ogrenciler
(
id char(4),
isim_soyisim varchar(30),
not_ort real,
kayit_tarih date
);

--varolan bir tablodan yeni bir tablo olusturma
CREATE TABLE ogrenci_ortalama
as 
select isim_soyisim,not_ort
from ogrenciler;

--SELECT - DQL-
SELECT * FROM ogrenciler; --Bir tablodaki butun verileri cagirmak istersek * kullan
SELECT * FROM ogrenci_ortalama;
SELECT isim_soyisim FROM ogrenciler;
SELECT isim_soyisim,kayit_tarih FROM ogrenciler; --birdenfazla field cagirmak icinde kullann