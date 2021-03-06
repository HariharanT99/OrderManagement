USE [OrderManagementSystem]
GO
DELETE FROM [dbo].[OrderDetail]
GO
DELETE FROM [dbo].[Product]
GO
DELETE FROM [dbo].[Category]
GO
DELETE FROM [dbo].[Order]
GO
DELETE FROM [dbo].[ShippingAddress]
GO
DELETE FROM [dbo].[User]
GO
DELETE FROM [dbo].[Role]
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (2, N'Customer')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [DOB], [MailId], [IsActive], [CreatedAt], [RoleId]) VALUES (2, N'Mohammed', N'Thahseen', CAST(N'1999-10-21' AS Date), N'test1@test.com', 1, CAST(N'2021-10-25T13:18:00.000' AS DateTime), 2)
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [DOB], [MailId], [IsActive], [CreatedAt], [RoleId]) VALUES (7, N'Mohammed', N'Falil', CAST(N'1999-08-20' AS Date), N'test2@test.com', 1, CAST(N'2021-10-25T13:18:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [DOB], [MailId], [IsActive], [CreatedAt], [RoleId]) VALUES (8, N'Mohammed', N'Zaid', CAST(N'1999-08-20' AS Date), N'test3@test.com', 1, CAST(N'2021-10-25T13:18:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [DOB], [MailId], [IsActive], [CreatedAt], [RoleId]) VALUES (9, N'Yukesh', N'Yukesh', CAST(N'1999-08-20' AS Date), N'test4@test.com', 1, CAST(N'2021-10-25T13:18:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [DOB], [MailId], [IsActive], [CreatedAt], [RoleId]) VALUES (10, N'Hari', N'Haran', CAST(N'1999-08-20' AS Date), N'test5@test.com', 1, CAST(N'2021-10-25T13:18:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [DOB], [MailId], [IsActive], [CreatedAt], [RoleId]) VALUES (11, N'Reshma', N'Reshma', CAST(N'1999-08-20' AS Date), N'test7@test.com', 1, CAST(N'2021-10-25T13:18:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [DOB], [MailId], [IsActive], [CreatedAt], [RoleId]) VALUES (12, N'Vijay', N'Kumar', CAST(N'1999-08-20' AS Date), N'test6@test.com', 1, CAST(N'2021-10-25T13:18:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [DOB], [MailId], [IsActive], [CreatedAt], [RoleId]) VALUES (13, N'Sri', N'Vidhya', CAST(N'1999-08-20' AS Date), N'test8@test.com', 1, CAST(N'2021-10-25T13:18:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [DOB], [MailId], [IsActive], [CreatedAt], [RoleId]) VALUES (14, N'Vasundhara', N'Vasundhara', CAST(N'1999-08-20' AS Date), N'test9@test.com', 1, CAST(N'2021-10-25T13:18:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [DOB], [MailId], [IsActive], [CreatedAt], [RoleId]) VALUES (15, N'David', N'Rocco', CAST(N'1999-08-20' AS Date), N'test10@test.com', 1, CAST(N'2021-10-25T13:18:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [DOB], [MailId], [IsActive], [CreatedAt], [RoleId]) VALUES (16, N'David', N'Peterson', CAST(N'1999-08-20' AS Date), N'test11@test.com', 1, CAST(N'2021-10-25T13:18:00.000' AS DateTime), 2)
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [DOB], [MailId], [IsActive], [CreatedAt], [RoleId]) VALUES (17, N'Emma', N'Petty', CAST(N'1999-08-20' AS Date), N'test12@test.com', 1, CAST(N'2021-10-25T13:18:00.000' AS DateTime), 2)
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [DOB], [MailId], [IsActive], [CreatedAt], [RoleId]) VALUES (18, N'Veena', N'Jayaraj', CAST(N'1999-08-20' AS Date), N'test13@test.com', 1, CAST(N'2021-10-25T13:18:00.000' AS DateTime), 2)
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [DOB], [MailId], [IsActive], [CreatedAt], [RoleId]) VALUES (22, N'Harry', N'Potter', CAST(N'2000-12-24' AS Date), N'test142@test.com', 1, CAST(N'2021-10-25T15:15:54.967' AS DateTime), 2)
INSERT [dbo].[User] ([UserId], [FirstName], [LastName], [DOB], [MailId], [IsActive], [CreatedAt], [RoleId]) VALUES (23, N'Harry', N'Potter', CAST(N'2000-12-24' AS Date), N'test42@test.com', 1, CAST(N'2021-10-25T15:17:00.307' AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[ShippingAddress] ON 

INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [UserId], [Address]) VALUES (7, 2, N'711-2880 Nulla St.
Mankato Mississippi 96522')
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [UserId], [Address]) VALUES (8, 7, N'935-9940 Tortor. Street
Santa Rosa MN 98804')
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [UserId], [Address]) VALUES (9, 8, N'347-7666 Iaculis St.
Woodruff SC 49854')
INSERT [dbo].[ShippingAddress] ([ShippingAddressId], [UserId], [Address]) VALUES (10, 9, N'347-7666 Iaculis St.
Woodruff SC 49854')
SET IDENTITY_INSERT [dbo].[ShippingAddress] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderId], [UserId], [ShippingAddressId], [CreatedAt], [DeliveryDate], [IsCancelled]) VALUES (1, 2, 7, CAST(N'2021-10-25T14:25:32.927' AS DateTime), CAST(N'2021-10-30' AS Date), 0)
INSERT [dbo].[Order] ([OrderId], [UserId], [ShippingAddressId], [CreatedAt], [DeliveryDate], [IsCancelled]) VALUES (2, 7, 8, CAST(N'2021-10-25T14:25:32.927' AS DateTime), CAST(N'2021-10-30' AS Date), 0)
INSERT [dbo].[Order] ([OrderId], [UserId], [ShippingAddressId], [CreatedAt], [DeliveryDate], [IsCancelled]) VALUES (3, 8, 9, CAST(N'2021-10-25T14:25:32.927' AS DateTime), CAST(N'2021-10-30' AS Date), 0)
INSERT [dbo].[Order] ([OrderId], [UserId], [ShippingAddressId], [CreatedAt], [DeliveryDate], [IsCancelled]) VALUES (4, 9, 10, CAST(N'2021-10-25T14:25:32.927' AS DateTime), CAST(N'2021-10-30' AS Date), 0)
INSERT [dbo].[Order] ([OrderId], [UserId], [ShippingAddressId], [CreatedAt], [DeliveryDate], [IsCancelled]) VALUES (5, 8, 9, CAST(N'2021-10-25T14:25:32.927' AS DateTime), CAST(N'2021-11-06' AS Date), 0)
INSERT [dbo].[Order] ([OrderId], [UserId], [ShippingAddressId], [CreatedAt], [DeliveryDate], [IsCancelled]) VALUES (6, 9, 10, CAST(N'2021-10-25T14:25:32.927' AS DateTime), CAST(N'2021-11-05' AS Date), 0)
INSERT [dbo].[Order] ([OrderId], [UserId], [ShippingAddressId], [CreatedAt], [DeliveryDate], [IsCancelled]) VALUES (8, 2, 7, CAST(N'2021-10-25T16:33:39.427' AS DateTime), CAST(N'2021-10-30' AS Date), 0)
INSERT [dbo].[Order] ([OrderId], [UserId], [ShippingAddressId], [CreatedAt], [DeliveryDate], [IsCancelled]) VALUES (9, 2, 7, CAST(N'2021-10-25T16:34:06.350' AS DateTime), CAST(N'2021-10-30' AS Date), 0)
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (1, N'Mobile Phone')
INSERT [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (2, N'TV')
INSERT [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (3, N'Headset')
INSERT [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (4, N'Laptop')
INSERT [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (5, N'Washing Machine')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (23, 1, N'Samsung M10', 100, 10, 13590.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (24, 1, N'Samsung M10 Pro', 10, 50, 19290.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (25, 1, N'Mi A2', 320, 35, 10.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (26, 1, N'Lenovo P20', 210, 10, 33590.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (27, 1, N'Moto G60', 60, 10, 13490.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (28, 2, N'Samsung QLED42', 90, 10, 53490.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (29, 2, N'Mi SmartTV 32', 100, 10, 43490.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (30, 2, N'Mi SmartTV 42', 90, 10, 63490.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (31, 2, N'Toshiba Q90', 120, 0, 50490.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (32, 2, N'Samsung QLED40', 90, 0, 48490.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (33, 3, N'Noise Shotsgroove', 0, 22, 4890.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (34, 3, N'Noise Qbuds', 110, 0, 6890.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (35, 3, N'Jabra P100', 400, 0, 2890.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (36, 3, N'Boult A10', 200, 0, 1890.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (37, 3, N'Boult A20', 100, 0, 3890.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (38, 4, N'Dell Inspirom', 100, 0, 73890.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (39, 4, N'HP Probook', 200, 0, 83890.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (40, 4, N'Apple Pro M1', 200, 0, 99890.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (41, 4, N'Hp Omen A30', 100, 0, 73890.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (42, 5, N'Samsung Top Load A20', 100, 0, 25890.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (43, 5, N'Onida Front load', 200, 0, 10890.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [CategoryId], [ProductName], [ProductInHand], [ProductOnOrder], [Price], [PriceUpdatedAt], [IsActive]) VALUES (44, 5, N'Samsung Front Load', 100, 0, 25890.0000, CAST(N'2021-10-25T14:07:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [OrderPrice], [IsCancelled]) VALUES (1, 1, 23, 10, 13590.0000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [OrderPrice], [IsCancelled]) VALUES (2, 1, 24, 50, 19290.0000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [OrderPrice], [IsCancelled]) VALUES (3, 1, 25, 15, 2590.0000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [OrderPrice], [IsCancelled]) VALUES (4, 2, 26, 10, 2590.0000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [OrderPrice], [IsCancelled]) VALUES (5, 2, 25, 20, 10.0000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [OrderPrice], [IsCancelled]) VALUES (6, 2, 27, 10, 2590.0000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [OrderPrice], [IsCancelled]) VALUES (7, 3, 28, 10, 53490.0000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [OrderPrice], [IsCancelled]) VALUES (8, 4, 29, 10, 43490.0000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [OrderPrice], [IsCancelled]) VALUES (9, 5, 30, 10, 63490.0000, 0)
INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [Quantity], [OrderPrice], [IsCancelled]) VALUES (10, 6, 33, 22, 4890.0000, 0)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
