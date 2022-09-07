create database tablecheck		
use tablecheck


create table Images
(
img varchar(max) not null ,
name varchar(50)not null,
carid int identity(1,1) not null primary key,
)

create table Cardetails
(
sellerid nvarchar(100)  not null , -- connect with sellerid with login credentials
carid int identity(1,1) not null primary key, 
make int not null, ------Year
model varchar(50) not null, --Car name
company varchar(50) not null, --Manufacturer
price int not null,
foreign key (carid) References Images(carid)
)

create table Sellerdetails --JOIN WITH create seller account 
(
--cardetails--
sellerid nvarchar(100) not null primary key, --
password nvarchar(100) not null,
carid int identity(1,1) not null,
sellername varchar(100) not null,--
city varchar(50) not null,--
phonenumber int not null,--
foreign key (carid) References Cardetails(carid)
)

create table Buyerdetails
(
--link to 
--book in advance
--payment
--maintenance
--insurance
buyerid nvarchar(100) not null,--
buyername varchar(100) not null,
city varchar(20),
primary key (buyerid)
)
-------------------PAYMENT-------------
create table viaOnline
(
Accountid int not null primary key,
buyerid nvarchar(100) not null,--ask buyer to enter his buyerid
amount int not null,
foreign key (buyerid) references Buyerdetails(buyerid)
)

create table viaCash
(
paymentid int not null primary key,
buyerid int not null, --ask buyer to enter his buyerid
amount int not null,
foreign key (buyerid) references Buyerdetails(buyerid)
)

------------------------ Finance--
create table Financeold
(
carid int identity (1,1) not null ,
downpayment int not null,
tenure int not null,
bankname varchar(80),
foreign key(carid) references Cardetails(carid)
)
-----------SEPERATE DB FOR MAINTENANCE AND INSURANCE CUSTOMER LINKED
---------------------		TO BUYER TABLE
create table CarMI --MAINTENANCE AND INSURANCE--
(
carid int identity(100,1)  not null Primary key , 
buyerid nvarchar(100) not null, --ask buyer to enter his buyerid
make int not null,
model varchar(50) not null,
company varchar(50) not null,
Regnum varchar(10) not null, --CAR REGISTERATION NUMBER
foreign key (buyerid) References Buyerdetails(buyerid)
)

---------------- Maintenance--
create table Breakdown
(
--links to
--links to
--This buyer_id wants to register
carid int identity(100,1) not null ,
maintenaceBreakdown int identity(50,10) primary key,
repairparts varchar(max),
amount int not null,
foreign key(carid) references CarMI(carid)
)
create table Periodic
(
--links to
--This buyer_id wants to register
carid int identity(100,1) not null ,
periodicmaintenace int identity(50,5) primary key,
amount int not null,
duration varchar(50),--kitne months bad hogi
foreign key(carid) references CarMI(carid)
)

-----------------insurance----------------

create table uninsured -- if against car is not insured
(
carid int identity(100,1) not null ,
damage int not null, --amount of damage
details varchar(max),
foreign key(carid) references CarMI(carid)
)

create table coverage --coverage for accidents for body part
(
carid int identity(100,1) not null,
type varchar(100) not null, --degree of damage
Totalcost int not null,
foreign key(carid) references CarMI(carid)
)
create table BookInAdvance
(
--links to
--This buyer_id wants to bookinadvance
-- it has its own unique set of details.
adminid nvarchar(100) not null
Bookingid int identity(20,1) not null,
buyerid nvarchar(100), --seller yah buyer (id) se koi 1 buy krega
sellerid nvarchar(100),
variant varchar(50),
color varchar(50) not null,
deliverytime int not null,
foreign key(buyerid) references buyerdetails(buyerid),
foreign key(Sellerid) references sellerdetails(Sellerid)
)

create table SellerCredentials
(
sellerid nvarchar(100) not null,
pass nvarchar(100) not null
foreign key(sellerid) references Sellerdetails(sellerid)
)

create table buyerCredentials
(
buyerid nvarchar(100) not null,
pass nvarchar(100) not null
foreign key(buyerid) references Buyerdetails(buyerid)
)

create table admins
(
adminid nvarchar(100) not null,
adminpass nvarchar(100) not null
foreign key(adminid) references BookInAdvance(adminid)
)
