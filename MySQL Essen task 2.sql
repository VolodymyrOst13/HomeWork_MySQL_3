CREATE DATABASE HW_03_T_02_BD;

CREATE TABLE HW_03_T_02_BD.Orders
(
	Customer varchar(200), 
	OrderDate date, 
	OrderDetails varchar(200),
	Employee varchar(200) 
);

INSERT HW_03_T_02_BD.Orders(Customer, OrderDate, OrderDetails, Employee)
VALUES
(
 'Василий Петрович Лященко; Харьков, Лужная 15; (092)3212211;',
 '2009-12-28',
 'LV231 Джинсы, 45$, 5, 225$; DG30 Ремень, 30$, 5, 145$; LV12 Обувь, 26$, 5, 125$;',
 'Иван Иванович Белецкий'),
 ('Зигмунд Федорович Унакий; Киев, Дегтяревская 5; (092)7612343;',
 '2010-09-01',
 'GC11 Шапка, 32$, 10, 320#$; GC111 Футболка, 20$, 15, 300$;',
 'Светлана Олеговна Лялечкина'),
  ('Олег Евстафьевич Выжлецов; Чернигов, Киевская 5; (044)2134212;',
 '2010-09-18',
 'LV12 Обувь, 26$, 20, 520$; GC11 Шапка, 32$, 18, 576$;',
 'Светлана Олеговна Лялечкина'
 );
 SELECT * FROM HW_03_T_02_BD.Orders;

 ------------------------------------------------------------------------- 
 
 CREATE TABLE HW_03_T_02_BD.Customer  
(
    id INT AUTO_INCREMENT NOT NULL,
	surnamesN VARCHAR(30) NOT NULL,  
    nameN VARCHAR(30) NOT NULL, 
    patronymicN VARCHAR(30) DEFAULT 'Unknown', 
	dateR date,	
    PRIMARY KEY (id)
);

INSERT HW_03_T_02_BD.Customer( nameN, patronymicN, surnamesN, dateR)
VALUES
('Василий', 'Петрович', 'Лященко', now()),
('Зигмунд', 'Федорович', 'Унакий', now()),
('Олег', 'Евстафьевич', 'Выжлецов', now());
 SELECT * FROM HW_03_T_02_BD.Customer;

 
  -------------------------------------------------------------------------
 
  CREATE TABLE HW_03_T_02_BD.delivery
(
    id INT AUTO_INCREMENT NOT NULL,
    CustomerID int NOT NULL, 
	city VARCHAR(30) not null, 
    street varchar(30),
    house int,	
    FOREIGN KEY(CustomerID) references Customer(id),
    PRIMARY KEY (id, CustomerID)
);

INSERT HW_03_T_02_BD.delivery(CustomerID, city, street, house)
VALUES
(1, 'Харьков', 'Лужная', 15),
(1, 'Днепр', 'Богдана Хмельницкого', 16),
(2, 'Киев', 'Дегтяревская', 5),
(3, 'Чернигов', 'Киевская', 5);
 SELECT * FROM HW_03_T_02_BD.delivery;
 
 
  -------------------------------------------------------------------------

  CREATE TABLE HW_03_T_02_BD.phone 
(
	phone VARCHAR(20) NOT NULL,
    CustomerID int NOT NULL, 
    FOREIGN KEY(CustomerID) references Customer(id),
    PRIMARY KEY (phone, CustomerID)
);

INSERT HW_03_T_02_BD.phone(CustomerID, phone)
VALUES
(1, '(092)0000001'),
(1, '(095)0000001'),
(2, '(095)0000002'),
(3, '(095)0000003');

 SELECT * FROM HW_03_T_02_BD.phone;
 
 
  ------------------------------------------------------------------------- 
 
 CREATE TABLE HW_03_T_02_BD.Employee 
(
    id INT AUTO_INCREMENT NOT NULL,
	surnamesN VARCHAR(30) NOT NULL,   			 
    nameN VARCHAR(30) NOT NULL, 				 
    patronymicN VARCHAR(30) DEFAULT 'Unknown', 	 
    jobTitle VARCHAR(30) NOT NULL, 	           
	PRIMARY KEY (id)
);

INSERT HW_03_T_02_BD.Employee(surnamesN, nameN, patronymicN , jobTitle)
VALUES
('Белецкий', 'Иван', 'Иванович', 'Старший продавец'),
('Лялечкина', 'Светлана', 'Олеговна', 'Продавец');

 SELECT * FROM HW_03_T_02_BD.Employee;

 
------------------------------------------------------------------------- 
  
  CREATE TABLE HW_03_T_02_BD.store  
(
    id INT AUTO_INCREMENT NOT NULL,
	art VARCHAR(30) NOT NULL,  
    nameProduct VARCHAR(100) NOT NULL,   
    price double NOT NULL, 
    currency VARCHAR(10),
    totalStock int DEFAULT 0,
	PRIMARY KEY (id)
);


  
INSERT HW_03_T_02_BD.store(art, nameProduct, price, currency, totalStock)
VALUES
('LV12', 'Обувь', 26, '$', 1001),
('GC11', 'Шапка', 32, '$', 1002),
('GC111', 'Футболка', 20, '$', 1003),
('LV231', 'Джинсы', 45, '$', 1004),
('DG30', 'Ремень', 30, '$', 1005);

 SELECT * FROM HW_03_T_02_BD.store;
 
 
 ------------------------------------------------------------------------- 
 CREATE TABLE HW_03_T_02_BD.OrdersV2
(    
	OrderID int AUTO_INCREMENT NOT NULL,   
    PRIMARY KEY (OrderID),
       
    OrderDate date NOT NULL, 
    
    EmployeeID int,  
	FOREIGN KEY(EmployeeID) REFERENCES HW_03_T_02_BD.Employee(ID),     
    
 	CustomerID int,
 	FOREIGN KEY(CustomerID) REFERENCES HW_03_T_02_BD.Customer(ID),
    
    deliveryID int,
    FOREIGN KEY(deliveryID, CustomerID) REFERENCES HW_03_T_02_BD.delivery(ID, CustomerID), 
    
    phoneID VARCHAR(20) NOT NULL,
    FOREIGN KEY(phoneID, CustomerID) REFERENCES HW_03_T_02_BD.phone(phone, CustomerID)  
);

INSERT HW_03_T_02_BD.OrdersV2(OrderDate, EmployeeID, CustomerID, deliveryID, phoneID)
VALUES
(now(), 1, 1, 1, '(092)0000001'),
(now(), 2, 2, 3, '(095)0000002'),
(now(), 2, 3, 4, '(095)0000003');

 SELECT * FROM HW_03_T_02_BD.OrdersV2;

 
  ------------------------------------------------------------------------- 
  
 CREATE TABLE HW_03_T_02_BD.OrderDetails
 
(
	OrderID int NOT NULL, 		
	LineItem int NOT NULL,  	
	storeID int NOT NULL,    	
	totalQty int NOT NULL,  	

    FOREIGN KEY(OrderID) REFERENCES HW_03_T_02_BD.OrdersV2(OrderID),
	FOREIGN KEY(storeID) REFERENCES HW_03_T_02_BD.store(ID),
	PRIMARY KEY (OrderId, LineItem)
);

INSERT HW_03_T_02_BD.OrderDetails(OrderID, LineItem, storeID, totalQty)
VALUES
		(1, 1, 1, 20),
        (1, 2, 2, 18),
        (2, 1, 2, 10),
        (2, 2, 3, 15), 
		(3, 1, 4, 5),
		(3, 2, 5, 5),
		(3, 3, 1, 5);

 SELECT * FROM HW_03_T_02_BD.OrderDetails;