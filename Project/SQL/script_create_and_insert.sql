DROP DATABASE IF EXISTS `autoparts` ;

CREATE SCHEMA `autoparts` ;

USE autoparts;

#роли пользователей	
CREATE TABLE tbl_UserRoles(
	UserRoleID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	UserRole nvarchar(255) NOT NULL DEFAULT ''
);
#справочник пользователей
CREATE TABLE tbl_Users(
	UserID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	UserName nvarchar(255) NULL,
	Password nvarchar(255) NOT NULL DEFAULT '', #тут нужно шифрование
	UserRoleID int NULL,
	BirthDate datetime NULL,
	Email nvarchar(255) NOT NULL DEFAULT '',
	Title nvarchar(255) NOT NULL DEFAULT '',
	Notes nvarchar(255) NOT NULL DEFAULT '',
	LastLoginTime datetime NULL,
	LastLogoutTime datetime NULL,
	AddTime datetime NULL,
	Status bit NOT NULL DEFAULT 0
    ,FOREIGN KEY (UserRoleID)
	REFERENCES tbl_UserRoles(UserRoleID)
	);
#справочник торговых точек
CREATE TABLE tbl_Stores(
	StoreID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	Name nvarchar(255) NOT NULL DEFAULT '',
	Address nvarchar(255) NOT NULL DEFAULT '',
	Phone nvarchar(255) NOT NULL DEFAULT '',
	Notes nvarchar(255) NOT NULL DEFAULT '',
	AddTime datetime NULL,
	CreatorID int NULL,
    FOREIGN KEY (CreatorID)
	REFERENCES tbl_Users(UserID)
	);
#страны
CREATE TABLE tbl_Countries(
	CountryID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	Country nvarchar(255) NOT NULL DEFAULT '',
	CountryCode nvarchar(255) NOT NULL DEFAULT ''
);
#города, входят в страны
CREATE TABLE tbl_Cities(
	CityID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	City nvarchar(255) NOT NULL DEFAULT '',
	CountryID int NULL
    ,FOREIGN KEY (CountryID)
	REFERENCES tbl_Countries(CountryID) 
);
#поставщики
CREATE TABLE tbl_Suppliers(
	SupplierID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	Name nvarchar(255) NOT NULL DEFAULT '',
	LegalForm nvarchar(255) NOT NULL DEFAULT '',
	Bank nvarchar(255) NOT NULL DEFAULT '',
	Address nvarchar(255) NOT NULL DEFAULT '',
	CountryID int NULL,
	CityID int NULL,
	Phone nvarchar(255) NOT NULL DEFAULT '',
	Email nvarchar(255) NOT NULL DEFAULT '',
	Website nvarchar(255) NOT NULL DEFAULT '',
	Notes nvarchar(1024) NOT NULL DEFAULT '',
	Status nvarchar(255) NOT NULL DEFAULT '',
	AddTime datetime NULL,
	CreatorID int NULL
    ,FOREIGN KEY (CreatorID)
	REFERENCES tbl_Users(UserID)
    ,FOREIGN KEY (CityID)
	REFERENCES tbl_Cities(CityID)
    ,FOREIGN KEY (CountryID)
	REFERENCES tbl_Countries(CountryID)    
	);
#группы товаров
CREATE TABLE tbl_ProductGroups(
	ProductGroupID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	ProductGroup nvarchar(255) NOT NULL DEFAULT ''
	);
#тип товаров, входит в группы
CREATE TABLE tbl_ProductTypes(
	ProductTypeID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	ProductType nvarchar(255) NOT NULL DEFAULT '',
	ProductGroupID int NULL
    ,FOREIGN KEY (ProductGroupID)
	REFERENCES tbl_ProductGroups(ProductGroupID)
	);
#производители
CREATE TABLE tbl_Producers(
	ProducerID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	Name nvarchar(255) NOT NULL DEFAULT '',
	Code nvarchar(255) NOT NULL DEFAULT '',
	CountryID int NULL
    ,FOREIGN KEY (CountryID)
	REFERENCES tbl_Countries(CountryID)
);
#справочник товаров
CREATE TABLE tbl_Products(
	ProductID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	Code nvarchar(255) NOT NULL DEFAULT '',
	Name nvarchar(255) NOT NULL DEFAULT '',
	ProductGroupID int NULL,
	ProductTypeID int NULL,
	Price int NULL,
	Unit nvarchar(255) NOT NULL DEFAULT '',
	Status nvarchar(255) NOT NULL DEFAULT '',
	ProducerID int NULL,
	Notes nvarchar(1024) NOT NULL DEFAULT '',
	AddTime datetime NULL,
	CreatorID int NULL,
	Original bit NOT NULL DEFAULT 0
    ,FOREIGN KEY (CreatorID)
	REFERENCES tbl_Users(UserID)
    ,FOREIGN KEY (ProductGroupID)
	REFERENCES tbl_ProductGroups(ProductGroupID)
    ,FOREIGN KEY (ProductTypeID)
	REFERENCES tbl_ProductTypes(ProductTypeID)
    ,FOREIGN KEY (ProducerID)
	REFERENCES tbl_Producers(ProducerID)
	);
#заказы поставщикам
CREATE TABLE tbl_Purchases(
	PurchaseID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	PurchaseDate datetime NULL,
	StoreID int NULL,
	SupplierID int NULL,
	CreatorID int NULL,
	Amount int NULL,
	Status nvarchar(255) NOT NULL DEFAULT '',
	ArrivalDate datetime NULL,
	Notes nvarchar(255) NOT NULL DEFAULT '',
	AddTime datetime NULL
    ,FOREIGN KEY (StoreID)
	REFERENCES tbl_Stores(StoreID)
	,FOREIGN KEY (SupplierID)
	REFERENCES tbl_Suppliers(SupplierID)
	,FOREIGN KEY (CreatorID)
	REFERENCES tbl_Users(UserID)
	);
#заказанные товары поставщика
CREATE TABLE tbl_PurchasesProducts(
	PurchasesProductsID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	ProductID int NULL,	
	Quantity float NULL,
	Price float NULL,
	Amount float NULL,
	Party nvarchar(255) NOT NULL DEFAULT '',
	Notes nvarchar(255) NOT NULL DEFAULT '',
	AddTime datetime NULL,
	PurchaseID int NULL
    ,FOREIGN KEY (ProductID)
	REFERENCES tbl_Products(ProductID)
    ,FOREIGN KEY (PurchaseID)
	REFERENCES tbl_Purchases(PurchaseID)
	);
#справочник автомобилей
CREATE TABLE tbl_Cars(
	CarID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	ProducerID int NULL,
	Model nvarchar(255) NOT NULL DEFAULT '',
	ProduceYear datetime NULL,
	Engine nvarchar(255) NOT NULL DEFAULT '',
	BodyType nvarchar(255) NOT NULL DEFAULT ''    
    ,FOREIGN KEY (ProducerID)
	REFERENCES tbl_Producers(ProducerID)
	);
#таблица для связи многие ко многим между авто и запчастями
CREATE TABLE tbl_Applicability(
	ApplicabilityID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	CarID int NULL,
	ProductID int NULL
    ,FOREIGN KEY (ProductID)
	REFERENCES tbl_Products(ProductID)
    ,FOREIGN KEY (CarID)
	REFERENCES tbl_Cars(CarID)
	);
#справочник клиентов
CREATE TABLE tbl_Clients(
	ClientID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	Name nvarchar(255) NOT NULL DEFAULT '',
	LegalForm nvarchar(255) NOT NULL DEFAULT '',
	Loyalty nvarchar(255) NOT NULL DEFAULT '',
	Address nvarchar(255) NOT NULL DEFAULT '',
	CountryID int NULL,
	CityID int NULL,
	Phone nvarchar(255) NOT NULL DEFAULT '',
	Email nvarchar(255) NOT NULL DEFAULT '',
	Notes nvarchar(1024) NOT NULL DEFAULT '',
	CreatorID int NULL,
	Status nvarchar(255) NOT NULL DEFAULT '',
	AddTime datetime NULL
    ,FOREIGN KEY (CreatorID)
	REFERENCES tbl_Users(UserID)
    ,FOREIGN KEY (CityID)
	REFERENCES tbl_Cities(CityID)
    ,FOREIGN KEY (CountryID)
	REFERENCES tbl_Countries(CountryID) 
	);
#заказы/продажи клиентов
CREATE TABLE tbl_Sales(
	SaleID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	OrderNumber nvarchar(255) NOT NULL DEFAULT '',
	OrderDate datetime NULL,
	ClientID int NULL,
	PayForm nvarchar(255) NOT NULL DEFAULT '',
	StoreID int NULL,
	Notes nvarchar(255) NOT NULL DEFAULT '',
	CreatorID int NULL,
	SaleStatus nvarchar(255) NOT NULL DEFAULT '',
	DoneDate datetime NULL,
	AddTime datetime NULL
    ,FOREIGN KEY (CreatorID)
	REFERENCES tbl_Users(UserID)
    ,FOREIGN KEY (StoreID)
	REFERENCES tbl_Stores(StoreID)
    ,FOREIGN KEY (ClientID)
	REFERENCES tbl_Clients(ClientID) 
	);
#заказанные товары клментов
CREATE TABLE tbl_SalesProducts(
	SalesProductID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	ProductID int NULL,
	Quantity float NULL,
	SalePrice int NULL,
	Discount float NULL,
	Notes nvarchar(255) NOT NULL DEFAULT '',
	AddTime datetime NULL,
	CreatorID int NULL,
	SaleID int NULL    
    ,FOREIGN KEY (CreatorID)
	REFERENCES tbl_Users(UserID)
    ,FOREIGN KEY (SaleID)
	REFERENCES tbl_Sales(SaleID)
    ,FOREIGN KEY (ProductID)
	REFERENCES tbl_Products(ProductID)
	);


INSERT INTO `autoparts`.`tbl_Countries`
(
`Country`,
`CountryCode`)
VALUES
('USA' ,
'1' ),
('France' ,
'33' ),
('Russia' ,
'789' ),
('China' ,
'86' ),
('Germany' ,
'49' ),
('Italy' ,
'72' ),
('Japan' ,
'27' );

INSERT INTO `autoparts`.`tbl_Cities`
(
`City`,
`CountryID`)
VALUES
(
'Moscow' ,
3 ),
(
'NY',
1 ),
(
'Lomonosov',
3 ),
(
'Paris',
2 ),
(
'Kronshtadt' ,
3 ),
(
'SPB' ,
3 );

INSERT INTO `autoparts`.`tbl_Producers`
(
`Name`,
`Code`,
`CountryID`)
VALUES
(
'Lmi' ,
'Code:53' ,
1 ),

(
'Valeo' ,
'Code:11' ,
5 ),

(
'LUK' ,
'Code:3' ,
3 ),

(
'Votex' ,
'Code:14' ,
1 ),

(
'Brembo',
'Code:666' ,
5 ),
(
'Mercedes Benz',
'111' ,
5 ),
(
'VolksWagen',
'Code:6126' ,
5 ),
(
'Fiat',
'Code:661' ,
2 ),
(
'Mitsubishi',
'Code:12' ,
7 ),
(
'Man',
'Code:321' ,
1 );


INSERT INTO `autoparts`.`tbl_Cars`
(
`ProducerID`,
`Model`,
`ProduceYear`,
`Engine`,
`BodyType`)
VALUES
(
6 ,
'S600' ,
'2000-01-01' ,
'Engine: 3.2',
'sedan' ),

(
7 ,
'Passat',
'2000-01-01' ,
'Engine: 1.8' ,
'sedan' ),

(
8 ,
'Punto' ,
'2013-01-01' ,
'Engine: 1.4' ,
'sedan' ), 

(
9 ,
'Lancer' ,
'1993-01-01' ,
'Engine: 1.5' ,
'universal' ), 

(
10 ,
'TGM' ,
'1998-01-01' ,
'Engine: 3.2' ,
'truck' );


INSERT INTO `autoparts`.`tbl_UserRoles`
(
`UserRole`)
VALUES
(
'admin' ),

(
'manager' ),


(
'user' );

INSERT INTO `autoparts`.`tbl_Users` 
( 
UserName,
UserRoleID, 
Password, 
BirthDate, 
email, 
Title)
VALUES 
( 
'Lola',
2 ,
'1253', 
'1994-10-11', 
'lola@mail.ru', 
'cat'), 
( 
'Anna', 
2,
'12443', 
'1984-11-04', 
'anna@mail.ru', 
'morning'), 
( 
'Alex', 
1,
'12377', 
'1974-05-12', 
'alexs@mail.ru', 
'summer'), 
( 
'Maks', 
3,
'1113', 
'1972-10-04', 
'maks@mail.ru', 
'evening');


INSERT INTO `autoparts`.`tbl_Clients`
(
`Name`,
`LegalForm`,
`Address`,
`CountryID`,
`CityID`)
VALUES
(
'Ivan' ,
'fiz',
'Avrova str, 15-50' ,
3 ,
1 
),
(
'Ivan S',
'fiz',
'Avrova str, 15-50' ,
3 ,
1 
),
(
'Lola G' ,
'fiz',
'Gorkushenko str, 154-50' ,
3 ,
1 
),
(
'Alex' ,
'fiz',
'Nevsky pr. str, 14-50' ,
3 ,
1 
);



INSERT INTO `autoparts`.`tbl_ProductGroups`
(
`ProductGroup`)
VALUES
(
'engine' ),

(
'wheel' ),

(
'Oil' ),

(
'Windshield' ),

(
'Headlamp' );



INSERT INTO `autoparts`.`tbl_ProductTypes`
(
`ProductType`,
`ProductGroupID`)
VALUES
(
'Whinet wheels',
2 ),
(
'Summer wheels',
2 );



INSERT INTO `autoparts`.`tbl_Products`
(
`Code`,
`Name`,
`ProductGroupID`,
`ProductTypeID`,
`Price`,
`Unit`)
VALUES
(
'Code:1' ,
'GoodYear 12' ,
2 ,
1 ,
3500 ,
'pieces' ),

(
'Code:23' ,
'GoodYear 121',
2 ,
2 ,
1500 ,
'pieces'),

(
'Code:143' ,
'Oil GeneralMotors' ,
3 ,
null ,
5500 ,
'liters'),

(
'Code:29' ,
'Oil Shell' ,
3 ,
null ,
3800 ,
'liters'),

(
'Code:99' ,
'Oil Lukoil' ,
3 ,
null ,
8000 ,
'liters');

INSERT INTO `autoparts`.`tbl_Stores`
(
`Name`,
`Address`,
`Phone`)
VALUES
(
'CoolCars' ,
'Pulkovo str., 18' ,
'4555599' );


INSERT INTO `autoparts`.`tbl_Suppliers`
(
`Name`,
`LegalForm`,
`Bank`,
`Address`,
`CountryID`,
`CityID`,
`Phone`,
`Email`,
`Website`)
VALUES
(
'Pupkino' ,
'legal',
'Bank:Union' ,
'Finland str., 11',
3 ,
6 ,
'6775663' ,
'pupkino@gmail.com' ,
'pupkino.com' ),

(
'Onion' ,
'physical' ,
'Bank:VTB' ,
'Finland str., 55' ,
3 ,
6 ,
'9987655' ,
'onion@mail.ru' ,
'onion.ru'  ),

(
'United' ,
'legal',
'Bank:Tinkoff' ,
'Gorkushenko str., 3' ,
3 ,
6 ,
'4566744' ,
'united@gmail.com ',
'united.ru' );
INSERT INTO autoparts.tbl_sales
VALUES (8,'1235', DATE_ADD(CURDATE(), INTERVAL -30 DAY),2,'cash',1,'',1,'1',null,CURDATE())
,(2,'1235', DATE_ADD(CURDATE(), INTERVAL -30 DAY),2,'cash',1,'',1,'1',null,CURDATE())
,(3,'1236', DATE_ADD(CURDATE(), INTERVAL -35 DAY),3,'cash',1,'',1,'2',null,CURDATE())
,(4,'1237', DATE_ADD(CURDATE(), INTERVAL -35 DAY),1,'cash',1,'',1,'1',null,CURDATE())
,(5,'1238', DATE_ADD(CURDATE(), INTERVAL -36 DAY),2,'cash',1,'',1,'1',null,CURDATE())
,(6,'1239', DATE_ADD(CURDATE(), INTERVAL -36 DAY),4,'cash',1,'',1,'3',null,CURDATE())
,(7,'1244', DATE_ADD(CURDATE(), INTERVAL -36 DAY),4,'cash',1,'',1,'1',null,CURDATE())
