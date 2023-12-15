show databases;
create database Art_Gallary;

use art_gallary;

create table paintings(
id int primary key,
name varchar(20),
artist_id int,
listed_price decimal(10,2)
);

desc paintings;

insert into paintings 
values
(11,'Miracle',1,300.00),
(12,'sushine',1,700.00),
(13,'pretty women',2,2800.00),
(14,'Handsome man',2,2300.00),
(15,'barbie',3,250.00),
(16,'cool painting',3,5000.00),
(17,'black square #1000',3,50.00),
(18,'Mountains',4,1300.00);

select * from paintings;

create table artists(
id int primary key,
first_name Varchar(20),
last_name varchar(20)
);

desc artists;

insert into artists 
values 
(1,'Thomas','Black'),
(2,'Kate','Smith'),
(3,'Natali','Wein'),
(4,'Francesco','Benelli');

select * from artists;
alter table Paintings add constraint foreign key (artist_id) references artists (id);

show create table paintings;

create table collectors(
id int primary key,
first_name Varchar(20),
last_name varchar(20)
);

desc collectors;

insert into collectors 
values 
(101,'Brandon','Cooper'),
(102,'Laura','Fisher'),
(103,'Christina','Buffet'),
(104,'steve','Stevneson');

select * from collectors;

create table Sales(
id int primary key,
date date,
painting_id int,
artist_id int,
collector_id int,
sales_price decimal(10,2)
);
desc sales;

alter table sales add constraint foreign key (painting_id) references Paintings (id);
alter table sales add constraint foreign key (artist_id) references artists (id);
alter table sales add constraint foreign key (collector_id) references collectors (id);

desc sales;
show create table sales;

insert into sales 
values
(1001,'2021-11-01',13,2,104,2500.00),
(1002,'2021-11-10',14,2,102,2300.00),
(1003,'2021-11-10',11,1,102,300.00),
(1004,'2021-11-15',16,3,103,4000.00),
(1005,'2021-11-22',15,3,103,200.00),
(1006,'2021-11-12',17,3,103,50.00);

select * from sales;

-- Q.1  We want to list paintings that are priced higher than the average. 
select * from paintings;
select avg(listed_price) from paintings;
select id,name,listed_price from paintings where listed_price > (select avg(listed_price) from paintings);

-- Q.2 we want to list all collectors who purchased paintings from our gallery. 
select * from collectors;
select * from sales; 	 	
select distinct first_name, last_name from collectors join sales on collectors.id=sales.collector_id;

-- Q3 we want to see the total amount of sales for each artist who has sold at least one painting in our gallery.
select * from Sales;
select * from artists; 
select artists.first_name, artists.last_name, sum(sales.sales_price) as totalsale from artists 
join sales on artists.id = sales.artist_id group by artists.id having totalsale > 0;

-- Q.4 we want to calculate the number of paintings purchased through our gallery.
select * from paintings;
select count(*) as number_of_painting_purchased from paintings;

-- Q.5 we want to show the first names and the last names of the artists who had zero sales with our gallery.
select * from Artists;
select * from sales;
select artists.first_name, artists.last_name from artists;
select distinct artists.first_name, artists.last_name from artists join sales on artists.id=sales.artist_id;
select artists.first_name, artists.last_name from artists left join sales 
on artists.id=sales.artist_id where sales.id is null;

