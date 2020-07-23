SET SQL_SAFE_UPDATES = 0;
-- CREATING A NEW SCHEMA NAMED 'ASSIGNMENT'
create schema assignment;
use assignment;

-- CREATING THE TABLES AND IMPORTING THE DATA FILES
create table bajaj(
market_date varchar(20) null,
open_price double null,
high_price double null,
low_price double null,
close_price double null,
wap double null,
no_of_shares mediumint null,
no_of_trades mediumint null,
total_turnover bigint null,
deliverable_qty bigint null,
percent_deli_to_traded_qty double null,
spread_high_low double null,
spread_close_open double null
);

select * from bajaj; -- checking if file is imported

create table hero(
market_date varchar(20) null,
open_price double null,
high_price double null,
low_price double null,
close_price double null,
wap double null,
no_of_shares mediumint null,
no_of_trades mediumint null,
total_turnover bigint null,
deliverable_qty bigint null,
percent_deli_to_traded_qty double null,
spread_high_low double null,
spread_close_open double null
);

 select * from hero;
 
create table eicher(
market_date varchar(20) null,
open_price double null,
high_price double null,
low_price double null,
close_price double null,
wap double null,
no_of_shares mediumint null,
no_of_trades mediumint null,
total_turnover bigint null,
deliverable_qty bigint null,
percent_deli_to_traded_qty double null,
spread_high_low double null,
spread_close_open double null
);

 select * from eicher;
 
create table tvs(
market_date varchar(20) null,
open_price double null,
high_price double null,
low_price double null,
close_price double null,
wap double null,
no_of_shares mediumint null,
no_of_trades mediumint null,
total_turnover bigint null,
deliverable_qty bigint null,
percent_deli_to_traded_qty double null,
spread_high_low double null,
spread_close_open double null
);

select * from tvs;

create table tcs(
market_date varchar(20) null,
open_price double null,
high_price double null,
low_price double null,
close_price double null,
wap double null,
no_of_shares mediumint null,
no_of_trades mediumint null,
total_turnover bigint null,
deliverable_qty bigint null,
percent_deli_to_traded_qty double null,
spread_high_low double null,
spread_close_open double null
);

select * from tcs;

create table infosys(
market_date varchar(20) null,
open_price double null,
high_price double null,
low_price double null,
close_price double null,
wap double null,
no_of_shares mediumint null,
no_of_trades mediumint null,
total_turnover bigint null,
deliverable_qty bigint null,
percent_deli_to_traded_qty double null,
spread_high_low double null,
spread_close_open double null
);

select * from infosys;

-- CHANGING TYPE OF DATE COLUMNS OF ALL THE TABLES FOR ANALYSIS

-- we can create a function that will select the month name and another one to convert it into numerical format
-- this will help us convert the format of the date columns in all tables repeatedly

-- defining function to format month name
DELIMITER $$
create function format_month(month_name varchar(20))
returns varchar(3) deterministic

BEGIN 
	return (select SUBSTRING(month_name, 1, 3));
END $$
DELIMITER ;

DELIMITER $$
-- creating function to select name of month from date column
create function filter_month(market_date varchar(20))
returns varchar(20) deterministic

BEGIN
	return (select SUBSTRING_INDEX( SUBSTRING_INDEX( market_date, '-', 2), '-', -1));
END $$

DELIMITER ;

-- UPDATING FORMAT OF DATE COLUMNS OF ALL TABLES

select filter_month(market_date) from bajaj;
select format_month(filter_month(market_date)) from bajaj;

update bajaj
	set market_date = (
    select replace(market_date, filter_month(market_date), format_month(filter_month(market_date))));

update hero
	set market_date = (
    select replace(market_date, filter_month(market_date), format_month(filter_month(market_date))));
    
update tcs
	set market_date = (
    select replace(market_date, filter_month(market_date), format_month(filter_month(market_date))));

update eicher
	set market_date = (
    select replace(market_date, filter_month(market_date), format_month(filter_month(market_date))));

update infosys
	set market_date = (
    select replace(market_date, filter_month(market_date), format_month(filter_month(market_date))));
    
update tvs
	set market_date = (
    select replace(market_date, filter_month(market_date), format_month(filter_month(market_date))));

-- checking and updating date column format 
select market_date from bajaj;
select market_date from eicher;
select market_date from hero;
select market_date from infosys;
select market_date from tvs;
select market_date from tcs;

update bajaj
	set market_date = str_to_date(market_date, '%d-%M-%Y');
update hero
	set market_date = str_to_date(market_date, '%d-%M-%Y');
update eicher
	set market_date = str_to_date(market_date, '%d-%M-%Y');
update infosys
	set market_date = str_to_date(market_date, '%d-%M-%Y');
update tvs
	set market_date = str_to_date(market_date, '%d-%M-%Y');
update tcs
	set market_date = str_to_date(market_date, '%d-%M-%Y');
    
-- updating datatype of the date column
select market_date from bajaj;

alter table bajaj 
	modify market_date date;
alter table infosys 
	modify market_date date;
alter table hero 
	modify market_date date;
alter table tvs 
	modify market_date date;
alter table eicher 
	modify market_date date;
alter table tcs 
	modify market_date date;
    
-- PROBLEM 1:

-- Creating tables named bajaj1, hero1, eicher1, tvs1, tcs1, and infosys1 with 20-day MA
-- and 50-day MA

create table bajaj1 as (
	select market_date as 'date', close_price,
    avg(close_price) over(order by market_date rows 19 preceding) as '20_day_MA',
    avg(close_price) over(order by market_date rows 49 preceding) as '50_day_MA'
	from bajaj);

select * from bajaj1;

-- removing the moving averages for the initial days when the window size is less
-- than 20 and 50 respectively

update bajaj1 set 20_day_MA = NULL limit 19;
update bajaj1 set 50_day_MA = NULL limit 49;

-- doing the same process for all other tables
create table hero1 as (
	select market_date as 'date', close_price,
    avg(close_price) over(order by market_date rows 19 preceding) as '20_day_MA',
    avg(close_price) over(order by market_date rows 49 preceding) as '50_day_MA'
	from hero);

update hero1 set 20_day_MA = NULL limit 19;
update hero1 set 50_day_MA = NULL limit 49;
    
create table eicher1 as (
	select market_date as 'date', close_price,
    avg(close_price) over(order by market_date rows 19 preceding) as '20_day_MA',
    avg(close_price) over(order by market_date rows 49 preceding) as '50_day_MA'
	from eicher);
    
update eicher1 set 20_day_MA = NULL limit 19;
update eicher1 set 50_day_MA = NULL limit 49;
    
create table infosys1 as (
	select market_date as 'date', close_price,
    avg(close_price) over(order by market_date rows 19 preceding) as '20_day_MA',
    avg(close_price) over(order by market_date rows 49 preceding) as '50_day_MA'
	from infosys);
    
update infosys1 set 20_day_MA = NULL limit 19;
update infosys1 set 50_day_MA = NULL limit 49;
    
create table tcs1 as (
	select market_date as 'date', close_price,
    avg(close_price) over(order by market_date rows 19 preceding) as '20_day_MA',
    avg(close_price) over(order by market_date rows 49 preceding) as '50_day_MA'
	from tcs);
    
update tcs1 set 20_day_MA = NULL limit 19;
update tcs1 set 50_day_MA = NULL limit 49;
    
create table tvs1 as (
	select market_date as 'date', close_price,
    avg(close_price) over(order by market_date rows 19 preceding) as '20_day_MA',
    avg(close_price) over(order by market_date rows 49 preceding) as '50_day_MA'
	from tvs);
    
update tvs1 set 20_day_MA = NULL limit 19;
update tvs1 set 50_day_MA = NULL limit 49;

-- checking all new tables
select * from bajaj1;
select * from hero1;
select * from infosys1;
select * from tcs1;
select * from eicher1;
select * from tvs1;

-- PROBLEM 2:

-- creating a tabled named 'close_prices_master' containing the close prices of the stocks
-- for each day

create table close_prices_master as (
	select tvs.market_date as 'date', bajaj.close_price as bajaj, tcs.close_price as tcs,
    tvs.close_price as tvs, infosys.close_price as infosys, eicher.close_price as eicher,
    hero.close_price as hero
    from eicher inner join tvs using (market_date)
    inner join bajaj using (market_date)
    inner join hero using (market_date)
    inner join tcs using (market_date)
    inner join infosys using (market_date)
    order by tvs.market_date
    );
    
select * from close_prices_master;

-- PROBLEM 3:

-- creating tables with buy/sell/hold signals for the stocks based on long-term and short-term
-- moving averages for each day

create table bajaj2 as(
	select date, close_price,
    (case
		when 50_day_MA is NULL then 'HOLD'
        when 20_day_MA < 50_day_MA and (lag(50_day_MA, 1) over (order by date)) is not NULL
			and (lag(50_day_MA, 1) over (order by date)) < (lag(20_day_MA, 1) over (order by date))
            then 'SELL'
		when 20_day_MA > 50_day_MA and (lag(50_day_MA, 1) over (order by date)) is not NULL
			and (lag(50_day_MA, 1) over (order by date)) > (lag(20_day_MA, 1) over (order by date))
            then 'BUY'
		else 'HOLD'
    end) as 'signal'
    from bajaj1
);

create table tvs2 as(
	select date, close_price,
    (case
		when 50_day_MA is NULL then 'HOLD'
        when 20_day_MA < 50_day_MA and (lag(50_day_MA, 1) over (order by date)) is not NULL
			and (lag(50_day_MA, 1) over (order by date)) < (lag(20_day_MA, 1) over (order by date))
            then 'SELL'
		when 20_day_MA > 50_day_MA and (lag(50_day_MA, 1) over (order by date)) is not NULL
			and (lag(50_day_MA, 1) over (order by date)) > (lag(20_day_MA, 1) over (order by date))
            then 'BUY'
		else 'HOLD'
    end) as 'signal'
    from tvs1
);

create table eicher2 as(
	select date, close_price,
    (case
		when 50_day_MA is NULL then 'HOLD'
        when 20_day_MA < 50_day_MA and (lag(50_day_MA, 1) over (order by date)) is not NULL
			and (lag(50_day_MA, 1) over (order by date)) < (lag(20_day_MA, 1) over (order by date))
            then 'SELL'
		when 20_day_MA > 50_day_MA and (lag(50_day_MA, 1) over (order by date)) is not NULL
			and (lag(50_day_MA, 1) over (order by date)) > (lag(20_day_MA, 1) over (order by date))
            then 'BUY'
		else 'HOLD'
    end) as 'signal'
    from eicher1
);

create table infosys2 as(
	select date, close_price,
    (case
		when 50_day_MA is NULL then 'HOLD'
        when 20_day_MA < 50_day_MA and (lag(50_day_MA, 1) over (order by date)) is not NULL
			and (lag(50_day_MA, 1) over (order by date)) < (lag(20_day_MA, 1) over (order by date))
            then 'SELL'
		when 20_day_MA > 50_day_MA and (lag(50_day_MA, 1) over (order by date)) is not NULL
			and (lag(50_day_MA, 1) over (order by date)) > (lag(20_day_MA, 1) over (order by date))
            then 'BUY'
		else 'HOLD'
    end) as 'signal'
    from infosys1
);

create table tcs2 as(
	select date, close_price,
    (case
		when 50_day_MA is NULL then 'HOLD'
        when 20_day_MA < 50_day_MA and (lag(50_day_MA, 1) over (order by date)) is not NULL
			and (lag(50_day_MA, 1) over (order by date)) < (lag(20_day_MA, 1) over (order by date))
            then 'SELL'
		when 20_day_MA > 50_day_MA and (lag(50_day_MA, 1) over (order by date)) is not NULL
			and (lag(50_day_MA, 1) over (order by date)) > (lag(20_day_MA, 1) over (order by date))
            then 'BUY'
		else 'HOLD'
    end) as 'signal'
    from tcs1
);

create table hero2 as(
	select date, close_price,
    (case
		when 50_day_MA is NULL then 'HOLD'
        when 20_day_MA < 50_day_MA and (lag(50_day_MA, 1) over (order by date)) is not NULL
			and (lag(50_day_MA, 1) over (order by date)) < (lag(20_day_MA, 1) over (order by date))
            then 'SELL'
		when 20_day_MA > 50_day_MA and (lag(50_day_MA, 1) over (order by date)) is not NULL
			and (lag(50_day_MA, 1) over (order by date)) > (lag(20_day_MA, 1) over (order by date))
            then 'BUY'
		else 'HOLD'
    end) as 'signal'
    from hero1
);

-- checking the new tables with the signal column
select * from infosys2;
select * from bajaj2;
select * from tcs2;
select * from hero2;
select * from eicher2;
select * from tvs2;

-- PROBLEM 4:

-- creating user-defined function to display signal for a given date

DELIMITER $$
create function stock_signal(input_date date)
returns varchar(20) deterministic
 
 BEGIN
	return (select bajaj2.signal from bajaj2 where bajaj2.date = input_date);
 END $$
 
 DELIMITER ;
 
 -- selecting dates with corresponding signals to check the output of the function
select market_date as 'date', stock_signal(market_date) as 'signal' from bajaj;

-- checking the function output
select stock_signal('2017-08-03');
	-- expected output: 'HOLD'
	-- actual output: 'HOLD'
	-- conclusion: output natches expectations
select stock_signal('2018-05-10');
	-- expected output: 'BUY'
	-- actual output: 'BUY'
	-- conclusion: output natches expectations
select stock_signal('2018-01-25');
	-- expected output: 'SELL'
	-- actual output: 'SELL'
	-- conclusion: output natches expectations

-- PROBLEM 5:

-- checking some results for analysis

-- retrieving number of death crosses for each of the stock
select count(*) as number_of_deathcross
from bajaj2 where bajaj2.signal = 'SELL';

select count(*) as number_of_deathcross
from infosys2 where infosys2.signal = 'SELL';

select count(*) as number_of_deathcross
from tvs2 where tvs2.signal = 'SELL';

select count(*) as number_of_deathcross
from tcs2 where tcs2.signal = 'SELL';

select count(*) as number_of_deathcross
from eicher2 where eicher2.signal = 'SELL';

select count(*) as number_of_deathcross
from hero2 where hero2.signal = 'SELL';


-- retrieving number of golden crosses for each of the stock
select count(*) as number_of_goldencross
from bajaj2 where bajaj2.signal = 'BUY';

select count(*) as number_of_goldencross
from infosys2 where infosys2.signal = 'BUY';

select count(*) as number_of_goldencross
from tvs2 where tvs2.signal = 'BUY';

select count(*) as number_of_goldencross
from tcs2 where tcs2.signal = 'BUY';

select count(*) as number_of_goldencross
from eicher2 where eicher2.signal = 'BUY';

select count(*) as number_of_goldencross
from hero2 where hero2.signal = 'BUY';


-- overall market trend
select round((select close_price from bajaj order by market_date desc limit 1) - (select close_price from bajaj order by market_date limit 1)) as 'overall_market_trend';
 
select round((select close_price from tcs order by market_date desc limit 1) - (select close_price from tcs order by market_date limit 1)) as 'overall_market_trend';
 
select round((select close_price from eicher order by market_date desc limit 1) - (select close_price from eicher order by market_date limit 1)) as 'overall_market_trend';

select round((select close_price from infosys order by market_date desc limit 1) - (select close_price from infosys order by market_date limit 1)) as 'overall_market_trend';

select round((select close_price from tvs order by market_date desc limit 1) - (select close_price from tvs order by market_date limit 1)) as 'overall_market_trend';

select round((select close_price from hero order by market_date desc limit 1) - (select close_price from hero order by market_date limit 1)) as 'overall_market_trend';