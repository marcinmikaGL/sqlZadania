SELECT * from studenci WHERE plec='K' AND (len(nazwisko) >=5 AND len(nazwisko) <=8 );
SELECT * from studenci WHERE plec='K' AND (len(nazwisko) between 5 and 9 );
SELECT (imie+ ' ' +nazwisko) AS imie_nazwisko , (substring(imie,1,1)+ '.' +substring(nazwisko,1,1)) AS inicial  from studenci; 
Select * from studenci where MONTH(data_urodzenia) = (MONTH(GETDATE())-1);  
select data_urodzenia, dateadd(year,2,data_urodzenia) from studenci;
select data_urodzenia, dateadd(day,30,data_urodzenia) from studenci;
select * from studenci WHERE  MONTH(data_urodzenia) = MONTH(dateadd(MONTH,1,GETDATE()));
select *  from studenci WHERE (GETDATE() >= dateadd(YEAR,18,data_urodzenia)) AND plec = 'm' AND liczba_dzieci >0 ORDER BY substring(nazwisko,2,1) DESC ;
-- ile dni przezylem 
SELECT dateadd(day,10000, '1985-08-10') ;
--datediff przeliczanie czasu 
 select datediff(HOUR, '1985-08-10',getdate());
-- ktrzy studenci przyliki mniej niz 15000 
select *, datediff(day, data_urodzenia,getdate()) from studenci WHERE datediff(day, data_urodzenia,getdate()) < 15000;
-- ile osób ma taką samą licze lat życia 
select count(*) licza_osob , datediff(YEAR,data_urodzenia,getdate()) as wiek from studenci group by datediff(YEAR,data_urodzenia,getdate());
-- wysiwtlic informacjie o sumie laty zycia wszystkoch osob bez dzieci 
select sum( datediff(YEAR,data_urodzenia,getdate())) as suma_lat FROM studenci WHERE liczba_dzieci  = 0 ;
-- w których miastach miescha tylko jedna bezdzietna osoba 
select count(*) as ile_osob, miasto FROM studenci WHERE liczba_dzieci= 0  group by miasto  having count(*) = 1; 
-- wywietlic dane matek ktorych dlugosc nazwiska jest miejsca od sredniych dlugosci ojcow 
select * from studenci WHERE plec = 'm' AND liczba_dzieci >0  and len(nazwisko) <  (select avg(len(nazwisko)) from studenci WHERE plec = 'm' AND liczba_dzieci >0)
-- ile ojcow wyswietlio sie w przynajmiej 3 ojcow 
select count(*) as ilosc_ojcow, YEAR(data_urodzenia) as lata From studenci WHERE plec='m' AND liczba_dzieci > 0 group by YEAR(data_urodzenia) having count(*) >= 3 ;
-- najmlodszy ojciec 
Select TOP 1 * from studenci WHERE plec='m' AND liczba_dzieci > 0 ORDER BY data_urodzenia DESC;
Select * from studenci WHERE data_urodzenia = (Select max(data_urodzenia) from studenci WHERE plec='m' AND liczba_dzieci > 0);
Select * from studenci where miasto in (Select miasto from studenci where nazwisko = 'chwiejski' OR nazwisko = 'wszelka');
SELECT * FROM studenci as s WHERE (year(s.data_urodzenia) = 1982) OR (MONTH(data_urodzenia) = MONTH(dateadd(MONTH,1,GETDATE()))) OR (MONTH(data_urodzenia) = MONTH(dateadd(MONTH,-1,GETDATE())))
SELECT * FROM studenci as s WHERE s.plec = 'k' AND liczba_dzieci >0 OR YEAR(data_urodzenia) >= YEAR(dateadd(YEAR,18,GETDATE())) ORDER BY imie DESC

# 1 zajęcia - 26.11.2022
 
- SELECT imie, nazwisko, plec FROM `studenci`;
- SELECT * FROM `studenci` WHERE plec = 'k';
- SELECT * FROM `studenci` WHERE miasto != 'katowice'; || SELECT * FROM studenci WHERE miasto <> 'katowice'; || SELECT * FROM studenci WHERE not miasto = 'katowice';
- SELECT * FROM `studenci` WHERE miasto IN ('Katowice', 'Bytom', 'Chorzow');
- SELECT * FROM `studenci` WHERE `liczba_dzieci` = 0 AND `miasto` = 'katowice';
- SELECT * FROM `studenci` WHERE `liczba_dzieci` != 0 AND `miasto` IN ('Katowice', 'Chorzów');
- SELECT * FROM `studenci` WHERE `plec` = 'k' AND `miasto` IN ('Katowice', 'Chorzów');
- SELECT * FROM `studenci` WHERE`liczba_dzieci` BETWEEN 2 AND 4;
- SELECT * FROM `studenci` WHERE `nazwisko` NOT LIKE '%k%' AND `plec`= 'k';
- SELECT * FROM `studenci` WHERE `imie` LIKE '%a';
- SELECT * FROM `studenci` WHERE nazwisko LIKE '[abcd]%';
- SELECT count(*) as 'Liczba osób z dziećmi' FROM `studenci` WHERE `liczba_dzieci` <> 0;
- SELECT sum(liczba_dzieci) as 'Liczba dzieci' FROM `studenci`;
- SELECT count(*) as 'Liczba osób z dziećmi', sum(liczba_dzieci) as 'Liczba dzieci' FROM `studenci` WHERE liczba_dzieci <> 0;
- SELECT `miasto`, count(*) as 'Liczba mieszkańców' FROM `studenci` GROUP BY `miasto`;
- SELECT miasto, count(*) as 'Liczba mieszkańców' FROM studenci GROUP BY miasto HAVING count(*) > 2;
- SELECT miasto, count(*) as 'Liczba mieszkańców' FROM studenci WHERE liczba_dzieci = 0 GROUP BY miasto HAVING count(*) > 2;
- SELECT `plec`, count(*) as 'Liczba osób' FROM studenci GROUP BY `plec`;
- SELECT * FROM studenci WHERE liczba_dzieci = (SELECT MAX(liczba_dzieci) from studenci);
- SELECT *, LENGTH(nazwisko) as 'Długość nazwiska' FROM `studenci`;
- SELECT * FROM `studenci` WHERE LENGTH(nazwisko) BETWEEN 4 AND 9;
- SELECT nazwisko, REVERSE(nazwisko), LEFT(nazwisko, 2), RIGHT(nazwisko, 3), SUBSTRING(nazwisko, 2, 3) FROM `studenci` WHERE 1;
- SELECT nazwisko FROM studenci WHERE LEFT(nazwisko, 1) = RIGHT(nazwisko, 1);
- SELECT * FROM `studenci` WHERE YEAR(data_urodzenia) = 1982
- SELECT *, datepart(dw, data_urodzenia) FROM `studenci` WHERE 1
 
# 2 zajęcia - 10.12.22
 
- SELECT * FROM studenci WHERE plec='k' AND LEN(nazwisko) BETWEEN 5 AND 9
- SELECT imie, nazwisko, CONCAT(LEFT(imie, 1), '.', LEFT(nazwisko, 1)) AS 'inicjaly' FROM studenci
- SELECT plec, COUNT(plec) as 'Liczba matek i ojców' FROM studenci WHERE liczba_dzieci > 0 GROUP BY plec
- SELECT * FROM studenci WHERE MONTH(data_urodzenia) = MONTH(DATEADD(MONTH, -1, CURRENT_TIMESTAMP));
- declare @dt date = getdate() | SELECT * FROM studenci WHERE MONTH(data_urodzenia) = datepart(MM, dateadd(mm,1, @dt))
- SELECT * FROM studenci WHERE data_urodzenia <= DATEADD(yy, -18, GETDATE()) AND plec = 'k' AND liczba_dzieci > 0 ORDER BY SUBSTRING(nazwisko , 2, 1) DESC
- SELECT *, DATEADD(dd, 10000, data_urodzenia) AS 'Data przeżycia 10000 dni' FROM studenci
- SELECT *, datediff(dd, data_urodzenia, GETDATE()) AS 'Ilość dni na ziemi' FROM studenci
- select datediff(year, data_urodzenia, getdate()), count(*) from studenci group by datediff(year, data_urodzenia, getdate())
- select sum(datediff(year, data_urodzenia, getdate())) from studenci where liczba_dzieci=0
- select * from (select miasto, count(*) as 'ile' from studenci where liczba_dzieci = 0 group by miasto) as c where c.ile = 1
- select * from studenci where plec = 'k' and liczba_dzieci > 0 and (len(nazwisko) < (select avg(len(nazwisko)) from studenci where plec='m' and liczba_dzieci > 0))
- select year(data_urodzenia), count(*) from studenci where plec='m' and liczba_dzieci>0 group by year(data_urodzenia) having count (*) > 3
- select * from studenci where data_urodzenia = (select MAX(data_urodzenia) from studenci where liczba_dzieci > 0 and plec = 'm')




CREATE TABLE studenci(
  "imie" varchar(20) default NULL,
  "nazwisko" varchar(30) default NULL,
  "data_urodzenia" datetime default NULL,
  "plec" char(1) default NULL,
  "miasto" varchar(30) default NULL,
  "liczba_dzieci" int default NULL)
  


-- 
-- Zrzut danych tabeli "studenci"
-- 

INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Jacek', 'Kowalski', '1997-01-01' , 'M', 'Katowice', 2)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Ewa', 'Nijaka', '1980-05-20', 'K', 'Chorzow', 0)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Monika', 'Jakas', '1985-04-14', 'K', 'Gliwice', 0)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Katarzyna', 'Miastowa', '1982-01-10', 'K', 'Warszawa', 1)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Jacek', 'Chwiejski', '1981-04-02', 'M', 'Katowice', 1)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Barbara', 'Wszelka', '1981-05-24', 'K', 'Zabrze', 1)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Bogdan', 'Wiejski', '1983-10-20', 'M', 'Sosnowiec', 0)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Bogumila', 'zawadzka', '1981-11-14', 'K', 'Czeladz', 0)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Ewelina', 'Mostowa', '1982-12-02', 'K', 'Katowice', 2)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Marek', 'Pa?dek', '1982-09-28', 'M', 'Ruda ?l?ska', 0)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Slawomir', 'Kowalski', '1983-08-08', 'M', 'Katowice', 1)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Tomasz', 'Nowak', '1985-02-27', 'M', 'Katowice', 0)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Jaroslaw', 'Polski', '1982-05-11', 'M', 'Katowice', 0)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Kamila', 'Parker', '1981-10-01', 'K', 'Katowice', 2)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Pawel', 'Dolny', '1982-07-02', 'M', 'Katowice', 1)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Wojciech', 'Kargul', '1982-04-18', 'M', 'Zabrze', 1)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('James', 'Bond', '1983-02-28', 'M', 'Krakow', 0)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Lech', 'Bajerka', '1982-02-18', 'M', 'Warszawa', 0)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Maciej', 'Teples', '1983-08-08', 'M', 'Zabrze', 0)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Majka', 'Owakowa', '1982-01-12', 'K', 'Katowice', 1)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Krzysztof', 'Wolniewicz', '1982-09-01', 'M', 'Rybnik', 1)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Leszek', 'Gorny', '1982-04-02', 'M', 'Katowice', 0)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Marek', 'Plotowy', '1982-02-02', 'M', 'Chorzow', 1)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Jakub', 'Bondowy', '1984-01-18', 'M', 'Zabrze', 1)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Monika', 'Majowska', '1981-03-18', 'K', 'Katowice', 3)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Marek', 'Tipkowski', '1982-08-08', 'M', 'Zabrze', 0)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Olek', 'Olkowy', '1983-05-12', 'M', 'Katowice', 1)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Marcin', 'Matrowski', '1982-05-23', 'M', 'Ruda Slaska', 0)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Ewa', 'Kowalska', '2005-01-01', 'K', 'Katowice', 0)
INSERT INTO "studenci" (imie, nazwisko, data_urodzenia, plec, miasto, liczba_dzieci)
VALUES ('Ala', 'Akowa', '1978-12-12', 'K', 'Bytom', 2)
