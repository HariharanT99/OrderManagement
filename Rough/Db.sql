-- CREATE DATABASE OrderManagementSystem
-- USE OrderManagementSystem


CREATE TABLE [Role]
(
    RoleId TINYINT PRIMARY KEY IDENTITY(1,1),
    RoleName VARCHAR(10) NOT NULL
)

CREATE TABLE [User]
(
    UserId INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(18) NOT NULL,
    LastName VARCHAR(18) ,
    DOB DATE NOT NULL,
    MailId VARCHAR(30) NOT NULL UNIQUE,
    IsActive BIT NOT NULL,
    CreatedAt DATETIME NOT NULL,
    RoleId TINYINT NOT NULL,
    FOREIGN KEY (RoleId) REFERENCES [Role](RoleId)
)

CREATE TABLE ShippingAddress
(
    ShippingAddressId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    [Address] VARCHAR(60) NOT NULL,
    FOREIGN KEY (UserId) REFERENCES [User](UserId)
)

CREATE TABLE Category
(
    CategoryId INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(20) NOT NULL
)

CREATE TABLE Product
(
    ProductId INT PRIMARY KEY IDENTITY(1,1),
    CategoryId INT NOT NULL,
    ProductName VARCHAR(20) NOT NULL,
    ProductInHand INT NOT NULL,
    ProductOnOrder INT NOT NULL,
    Price SMALLMONEY NOT NULL,
    PriceUpdatedAt DATETIME NOT NULL,
    IsActive BIT NOT NULL,
    FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
)

CREATE TABLE [Order]
(
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT,
    ShippingAddressId INT ,
    CreatedAt DATETIME,
    DeliveryDate DATE,
    IsCancelled BIT,
    FOREIGN KEY (UserId) REFERENCES [User](UserId),
    FOREIGN KEY (ShippingAddressId) REFERENCES ShippingAddress(ShippingAddressId)
)

CREATE TABLE OrderDetail
(
    OrderDetailId INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT,
    ProductId INT,
    Quantity INT,
    OrderPrice SMALLMONEY,
    IsCancelled BIT,
    FOREIGN KEY (OrderId) REFERENCES [Order](OrderId),
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId)
)


INSERT INTO [User]
    (
    FirstName,
    LastName,
    DOB,
    MailId,
    IsActive,
    CreatedAt,
    RoleId
    )
VALUES
    ('Mohammed', 'Falil', '1999-08-20', 'test2@test.com', 1, '2021-10-25 13:18:00.000', 1),
    ('Mohammed', 'Zaid', '1999-08-20', 'test3@test.com', 1, '2021-10-25 13:18:00.000', 1),
    ('Yukesh', 'Yukesh', '1999-08-20', 'test4@test.com', 1, '2021-10-25 13:18:00.000', 1),
    ('Hari', 'Haran', '1999-08-20', 'test5@test.com', 1, '2021-10-25 13:18:00.000', 1),
    ('Reshma', 'Reshma', '1999-08-20', 'test7@test.com', 1, '2021-10-25 13:18:00.000', 1),
    ('Vijay', 'Kumar', '1999-08-20', 'test6@test.com', 1, '2021-10-25 13:18:00.000', 1),
    ('Sri', 'Vidhya', '1999-08-20', 'test8@test.com', 1, '2021-10-25 13:18:00.000', 1),
    ('Vasundhara', 'Vasundhara', '1999-08-20', 'test9@test.com', 1, '2021-10-25 13:18:00.000', 1),
    ('David', 'Rocco', '1999-08-20', 'test10@test.com', 1, '2021-10-25 13:18:00.000', 1),
    ('David', 'Peterson', '1999-08-20', 'test11@test.com', 1, '2021-10-25 13:18:00.000', 2),
    ('Emma', 'Petty', '1999-08-20', 'test12@test.com', 1, '2021-10-25 13:18:00.000', 2),
    ('Veena', 'Jayaraj', '1999-08-20', 'test13@test.com', 1, '2021-10-25 13:18:00.000', 2)

INSERT INTO Category
    (CategoryName)
VALUES
    ('Mobile Phone'),
    ('TV'),
    ('Headset'),
    ('Laptop'),
    ('Washing Machine')

INSERT INTO Product
    (
    CategoryId,
    ProductName,
    ProductInHand,
    ProductOnOrder,
    Price,
    PriceUpdatedAt,
    IsActive
    )
VALUES
    (1, 'Samsung M10', 100, 10, 13590, '2021-10-25 14:07:00.000', 1),
    (1, 'Samsung M10 Pro', 10, 50, 19290, '2021-10-25 14:07:00.000', 1),
    (1, 'Mi A2', 300, 35, 10, '2021-10-25 14:07:00.000', 1),
    (1, 'Lenovo P20', 200, 10, 33590, '2021-10-25 14:07:00.000', 1),
    (1, 'Moto G60', 50, 10, 13490, '2021-10-25 14:07:00.000', 1),
    (2, 'Samsung QLED42', 90, 10, 53490, '2021-10-25 14:07:00.000', 1),
    (2, 'Mi SmartTV 32', 100, 10, 43490, '2021-10-25 14:07:00.000', 1),
    (2, 'Mi SmartTV 42', 90, 10, 63490, '2021-10-25 14:07:00.000', 1),
    (2, 'Toshiba Q90', 120, 0, 50490, '2021-10-25 14:07:00.000', 1),
    (2, 'Samsung QLED40', 90, 0, 48490, '2021-10-25 14:07:00.000', 1),
    (3, 'Noise Shotsgroove', 0, 22, 4890, '2021-10-25 14:07:00.000', 1),
    (3, 'Noise Qbuds', 110, 0, 6890, '2021-10-25 14:07:00.000', 1),
    (3, 'Jabra P100', 400, 0, 2890, '2021-10-25 14:07:00.000', 1),
    (3, 'Boult A10', 200, 0, 1890, '2021-10-25 14:07:00.000', 1),
    (3, 'Boult A20', 100, 0, 3890, '2021-10-25 14:07:00.000', 1),
    (4, 'Dell Inspirom', 100, 0, 73890, '2021-10-25 14:07:00.000', 1),
    (4, 'HP Probook', 200, 0, 83890, '2021-10-25 14:07:00.000', 1),
    (4, 'Apple Pro M1', 200, 0, 99890, '2021-10-25 14:07:00.000', 1),
    (4, 'Hp Omen A30', 100, 0, 73890, '2021-10-25 14:07:00.000', 1),
    (5, 'Samsung Top Load A20', 100, 0, 25890, '2021-10-25 14:07:00.000', 1),
    (5, 'Onida Front load', 200, 0, 10890, '2021-10-25 14:07:00.000', 1),
    (5, 'Samsung Front Load', 100, 0, 25890, '2021-10-25 14:07:00.000', 1)



INSERT INTO ShippingAddress
    (
    UserId,
    [Address]
    )
VALUES
    (
        2, '711-2880 Nulla St.
Mankato Mississippi 96522'
),
    (7, '935-9940 Tortor. Street
Santa Rosa MN 98804'),
    (8, '347-7666 Iaculis St.
Woodruff SC 49854'),
    (9, '347-7666 Iaculis St.
Woodruff SC 49854')


INSERT INTO [Order]
    (
    UserId,
    ShippingAddressId,
    CreatedAt,
    DeliveryDate,
    IsCancelled
    )
VALUES
    (2, 7, GETDATE(), '2021-10-30', 0),
    (7, 8, GETDATE(), '2021-10-30', 0),
    (8, 9, GETDATE(), '2021-10-30', 0),
    (9, 10, GETDATE(), '2021-10-30', 0),
    (8, 9, GETDATE(), '2021-11-6', 0),
    (9, 10, GETDATE(), '2021-11-5', 0)

INSERT INTO [OrderDetail]
    (
    OrderId,
    ProductId,
    Quantity,
    OrderPrice,
    IsCancelled
    )
VALUES
    (1, 23, 10, 13590.0000, 0),
    (1, 24, 50, 19290.0000, 0),
    (1, 25, 15, 2590.0000, 0),
    (2, 26, 10, 2590.0000, 0),
    (2, 25, 20, 10.0000, 0),
    (2, 27, 10, 2590.0000, 0),
    (3, 28, 10, 53490.0000, 0),
    (4, 29, 10, 43490.0000, 0),
    (5, 30, 10, 63490.0000, 0),
    (6, 33, 22, 4890.0000, 0)