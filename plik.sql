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
