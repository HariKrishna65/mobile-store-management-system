drop database db_MobileShopManagementSystem;


CREATE DATABASE db_MobileShopManagementSystem;
use db_MobileShopManagementSystem;

CREATE TABLE tb_Customer(
    customer_ID INT PRIMARY KEY AUTO_INCREMENT,
    customer_Name VARCHAR(50) DEFAULT 'WALK IN CUSTOMER',
    customer_Mobile_Number VARCHAR(10) DEFAULT '0000000000'
    constraint chk_mob_num check(length(customer_Mobile_Number)=10)
);

insert into tb_Customer (customer_Mobile_Number) values (1234567);

CREATE TABLE tb_Repair_Request(
    repair_request_ID INT PRIMARY KEY AUTO_INCREMENT,
    customer_ID INT,
    received_Date DATE,
    return_Date DATE,
    device_Name VARCHAR(50),
    repair_Charges INT,
    status VARCHAR(20),
    FOREIGN KEY (customer_ID) REFERENCES tb_Customer(customer_ID) ON DELETE CASCADE
);




CREATE TABLE tb_Orders(
    order_ID INT PRIMARY KEY AUTO_INCREMENT,
    customer_ID INT,
    order_Date DATE,
    order_Time TIME,
    order_Total BIGINT,
    FOREIGN KEY (customer_ID) REFERENCES tb_Customer(customer_ID) on delete cascade
);


CREATE TABLE tb_Vendor(
    vendor_ID INT PRIMARY KEY AUTO_INCREMENT,
    vendor_Name VARCHAR(50)
);


CREATE TABLE tb_Category(
    category_ID INT PRIMARY KEY AUTO_INCREMENT,
    category_Name VARCHAR(50)
);

CREATE TABLE tb_Accessory(
    accessory_ID INT PRIMARY KEY AUTO_INCREMENT,
    category_ID INT,
    accessory_Name VARCHAR(50),
    accessory_Stock INT,
    accessory_Price_Per_Unit INT,
    accessory_Bought_Date DATE,
    FOREIGN KEY (category_ID) REFERENCES tb_Category(category_ID) on delete cascade
);

CREATE TABLE tb_Seller(
    seller_ID INT PRIMARY KEY AUTO_INCREMENT,
    seller_Name VARCHAR(50) DEFAULT 'BOXED PACKED',
    seller_CNIC_No BIGINT DEFAULT 0000000000000,
    seller_Address VARCHAR(75) DEFAULT 'BOXED PACKED',
    buy_Date DATE,
    buy_Time TIME
);

CREATE TABLE tb_Mobile(
    mobile_IMEI_No BIGINT PRIMARY KEY,
    seller_ID INT,
    vendor_ID INT,
    mobile_Model VARCHAR(25),
    mobile_Condition VARCHAR(10),
    mobile_Bought_Price BIGINT,
    mobile_Sell_Price BIGINT NULL,
    mrp BIGINT,
    FOREIGN KEY (seller_ID) REFERENCES tb_Seller(seller_ID) on delete cascade,
    FOREIGN KEY (vendor_ID) REFERENCES tb_Vendor(vendor_ID) on delete cascade
);

CREATE TABLE tb_Requested_Items(
    request_ID INT PRIMARY KEY AUTO_INCREMENT,
    item_Name VARCHAR(25)
);

CREATE TABLE tb_Order_Accessory_Details(
    order_ID INT,
    accessory_ID INT,
    PRIMARY KEY(order_ID, accessory_ID),
    FOREIGN KEY (order_ID) REFERENCES tb_Orders(order_ID),
    FOREIGN KEY (accessory_ID) REFERENCES tb_Accessory(accessory_ID)
);

CREATE TABLE tb_Order_Mobile_Details(
    order_ID INT,
    mobile_IMEI_No BIGINT,
    PRIMARY KEY(order_ID, mobile_IMEI_No),
    FOREIGN KEY (order_ID) REFERENCES tb_Orders(order_ID),
    FOREIGN KEY (mobile_IMEI_No) REFERENCES tb_Mobile(mobile_IMEI_No)
);


CREATE TABLE tb_Accessory_Requested_Items_Details(
    request_ID INT,
    accessory_ID INT,
    PRIMARY KEY(request_ID, accessory_ID),
    FOREIGN KEY (request_ID) REFERENCES tb_Requested_Items(request_ID),
    FOREIGN KEY (accessory_ID) REFERENCES tb_Accessory(accessory_ID)
);



INSERT INTO tb_Customer VALUES
(1, 'Ali Khan', 03123456789),
(2, 'Sana Ahmed', 03234567890),
(3, 'mohan kumar', 03234567997),
(4, 'rahul', 03234567599),
(5, 'Michael Johnson', 03567890123),
(6, 'Emily Davis', 03678901234),
(7, 'Chris Brown', 03789012345),
(8, 'Alice Johnson', 03890123456),
(9, 'Bob Smith', 03901234567),
(10, 'Ella Davis', 04012345678),
(11, 'Frank Brown', 04123456789),
(12, 'Grace Lee', 04234567890);


INSERT INTO tb_Repair_Request VALUES
(5, 2, '2018-11-22', '2018-11-25', 'iPhone 7', 200, 'Pending'),
(6, 3, '2018-11-26', '2018-11-29', 'iPad Air', 150, 'Completed'),
(7, 8, '2018-12-01', '2018-12-04', 'Samsung Galaxy Tab', 180, 'In Progress'),
(8, 9, '2018-12-03', '2018-12-06', 'Xiaomi Mi Pad', 120, 'Pending'),
(9, 10, '2018-12-05', '2018-12-08', 'Realme Pad', 130, 'Completed'),
(10, 11, '2018-12-07', '2018-12-10', 'Vivo Tab', 170, 'In Progress');


INSERT INTO tb_Vendor VALUES
(1, 'Apple'),
(2, 'Samsung'),
(3, 'Xiaomi'),
(4, 'Realme'),
(5, 'Motorola'),
(6, 'Vivo'),
(7, 'Oppo');


INSERT INTO tb_Category VALUES
(1, 'Chargers'),
(2, 'Screen Protectors'),
(3, 'Cases'),
(4, 'Headphones'),
(5, 'Cables'),
(6, 'Cases');

INSERT INTO tb_Accessory VALUES
(3, 1, 'Fast Charger', 20, 250, '2018-11-20'),
(4, 1, 'Normal Charger', 15, 200, '2018-11-18'),
(5, 2, 'Glass Protector', 25, 50, '2018-11-15'),
(6, 2, 'Plastic Protector', 30, 30, '2018-11-16'),
(7, 3, 'Hard Case', 30, 100, '2018-11-19'),
(8, 3, 'Soft Case', 25, 80, '2018-11-17'),
(9, 4, 'Bluetooth Headphones', 120, 300, '2018-11-14'),
(10, 4, 'Wired Headphones', 50, 150, '2018-11-12'),
(11, 5, 'USB-C Cable', 10, 80, '2018-11-21'),
(12, 5, 'Lightning Cable', 12, 100, '2018-11-22'),
(13, 6, 'Leather Case', 35, 120, '2018-11-23'),
(14, 6, 'Silicone Case', 25, 90, '2018-11-24'),
(15, 5, 'Micro USB Cable', 8, 60, '2018-11-25'),
(16, 6, 'Bumper Case', 30, 110, '2018-11-26'),
(17, 5, 'Type-C Cable', 15, 70, '2018-11-27'),
(18, 6, 'Clear Case', 20, 80, '2018-11-28');



INSERT INTO tb_Orders VALUES
(1, 1, '2018-11-22', '09:30:45', 250),
(2, 2, '2018-11-24', '14:10:20', 50),
(3, 4, '2018-11-25', '11:45:30', 150),
(4, 5, '2018-11-27', '16:20:15', 80),
(5, 6, '2018-11-28', '10:00:00', 80000),
(6, 7, '2018-11-29', '13:30:45', 70000);


INSERT INTO tb_Seller VALUES
(1, 'Seller1', 123456789012, 'Address1', '2018-11-20', '09:00:00'),
(2, 'Seller2', 234567890123, 'Address2', '2019-05-15', '10:30:00'),
(3, 'Seller3', 345678901234, 'Address3', '2020-02-10', '11:45:00'),
(4, 'Seller4', 456789012345, 'Address4', '2021-09-05', '14:15:00'),
(5, 'Seller5', 567890123456, 'Address5', '2022-06-30', '16:45:00');

INSERT INTO tb_Requested_Items VALUES
(1, 'Item1'),
(2, 'Item2'),
(3, 'Item3'),
(4,'item1'),
(5,'item2'),
(6,'item3'),
(7,'item4'),
(8,'item5');

INSERT INTO tb_Mobile VALUES
(374512362018127, NULL, 1, 'iPhone 8', 'NEW', 80000, NULL, 90000),
(374512362018128, NULL, 1, 'iPhone X', 'NEW', 100000, NULL, 120000),
(482362018127, NULL, 2, 'iPad Pro', 'NEW', 60000, NULL, 80000),
(482362018128, NULL, 2, 'Galaxy Tab S7', 'NEW', 70000, NULL, 90000),
(123456789012345, 1, 1, 'MobileModel1', 'Condition1', 500, 600, 400);

SELECT * FROM tb_Mobile;

INSERT INTO tb_Order_Mobile_Details VALUES
(1, 482362018127),
(2, 482362018128),
(3, 374512362018127),
(4, 374512362018128),
(5, 123456789012345);

INSERT INTO tb_Accessory_Requested_Items_Details (request_ID, accessory_ID) 
VALUES 
    (1, 3), 
    (2, 4),
    (3, 5),
    (4, 7),
    (5, 8),
    (6, 9);
INSERT INTO tb_Order_Accessory_Details (order_ID, accessory_ID) VALUES
(1, 3),
(1, 4),
(2, 5),
(2, 7),
(3, 8);

SELECT * FROM tb_Customer;
SELECT * FROM tb_Repair_Request;
SELECT * FROM tb_Vendor;
SELECT * FROM tb_Category;
SELECT * FROM tb_Accessory;
SELECT * FROM tb_Mobile;
SELECT * FROM tb_Orders;
SELECT * FROM tb_Seller;
select * from tb_Requested_Items;
SELECT * FROM tb_Order_Mobile_Details;
SELECT * FROM tb_Accessory_Requested_Items_Details;
SELECT * FROM tb_Order_Accessory_Details;



-- 1. Find the total number of repair requests.
SELECT COUNT(*) AS total_repair_requests FROM tb_Repair_Request;

-- 2. Find the total number of orders.
SELECT COUNT(*) AS total_orders FROM tb_Orders;

-- 3. Find the total number of customers.
SELECT COUNT(*) AS total_customers FROM tb_Customer;

-- 4. Find the total number of accessories in stock.
SELECT SUM(accessory_Stock) AS total_accessories_in_stock FROM tb_Accessory;

-- 5. Find the total number of mobiles in stock.
SELECT COUNT(*) AS total_mobiles_in_stock FROM tb_Mobile WHERE mobile_Sell_Price IS NULL;

-- 6. Find the total revenue generated from orders.
SELECT SUM(order_Total) AS total_revenue FROM tb_Orders;

-- 7 Calculate the total number of repair requests and orders per customer
SELECT c.customer_ID, c.customer_Name, 
       COUNT(rr.repair_request_ID) AS total_repair_requests, 
       COUNT(o.order_ID) AS total_orders
FROM tb_Customer c
LEFT JOIN tb_Repair_Request rr ON c.customer_ID = rr.customer_ID
LEFT JOIN tb_Orders o ON c.customer_ID = o.customer_ID
GROUP BY c.customer_ID;



-- 8. Find the top 5 customers with the highest total order amounts.
SELECT c.customer_Name, SUM(o.order_Total) AS total_amount
FROM tb_Customer c
JOIN tb_Orders o ON c.customer_ID = o.customer_ID
GROUP BY c.customer_ID
ORDER BY total_amount DESC
LIMIT 5;

-- 9. Find the average repair charges.
SELECT AVG(repair_Charges) AS avg_repair_charges FROM tb_Repair_Request;

-- 10. Find the most recent order date.
SELECT MAX(order_Date) AS most_recent_order_date FROM tb_Orders;



























DROP TABLE IF EXISTS tb_Customer_Mobile;

-- CREATE TABLE tb_Customer_Mobile(
--     customer_Mobile_ID INT PRIMARY KEY AUTO_INCREMENT,
--     customer_ID INT,
--     customer_Mobile_Number VARCHAR(10),
--     CONSTRAINT fk_customer_id FOREIGN KEY (customer_ID) REFERENCES tb_Customer(customer_ID) ON DELETE CASCADE
-- );

-- INSERT INTO tb_Customer_Mobile (customer_ID, customer_Mobile_Number) VALUES
-- (1, '03123456789'),
-- (1, '03123456780'),
-- (2, '03234567890'),
-- (3, '03234567997'),
-- (4, '03234567599'),
-- (5, '03567890123'),
-- (6, '03678901234'),
-- (7, '03789012345'),
-- (8, '03890123456'),
-- (9, '03901234567'),
-- (10, '04012345678'),
-- (11, '04123456789'),
-- (12, '04234567890');

-- ALTER TABLE tb_Customer DROP COLUMN customer_Mobile_Number;
