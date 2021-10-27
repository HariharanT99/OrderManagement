USE [OrderManagmentSystem]
GO
/****** Object:  StoredProcedure [dbo].[spGetCustomerOrder]    Script Date: 25-10-2021 18:16:39 ******/
DROP PROCEDURE [dbo].[spGetCustomerOrder]
GO
/****** Object:  StoredProcedure [dbo].[spGetAllOrder]    Script Date: 25-10-2021 18:16:39 ******/
DROP PROCEDURE [dbo].[spGetAllOrder]
GO
/****** Object:  StoredProcedure [dbo].[spCheckUserExist]    Script Date: 25-10-2021 18:16:39 ******/
DROP PROCEDURE [dbo].[spCheckUserExist]
GO
/****** Object:  StoredProcedure [dbo].[spCheckRoleExist]    Script Date: 25-10-2021 18:16:39 ******/
DROP PROCEDURE [dbo].[spCheckRoleExist]
GO
/****** Object:  StoredProcedure [dbo].[spCheckProductAvailability]    Script Date: 25-10-2021 18:16:39 ******/
DROP PROCEDURE [dbo].[spCheckProductAvailability]
GO
/****** Object:  StoredProcedure [dbo].[spCheckMailExist]    Script Date: 25-10-2021 18:16:39 ******/
DROP PROCEDURE [dbo].[spCheckMailExist]
GO
/****** Object:  StoredProcedure [dbo].[spCancelOrder]    Script Date: 25-10-2021 18:16:39 ******/
DROP PROCEDURE [dbo].[spCancelOrder]
GO
/****** Object:  StoredProcedure [dbo].[spAddUser]    Script Date: 25-10-2021 18:16:39 ******/
DROP PROCEDURE [dbo].[spAddUser]
GO
/****** Object:  StoredProcedure [dbo].[spAddStock]    Script Date: 25-10-2021 18:16:39 ******/
DROP PROCEDURE [dbo].[spAddStock]
GO
/****** Object:  StoredProcedure [dbo].[spAddOrderDetails]    Script Date: 25-10-2021 18:16:39 ******/
DROP PROCEDURE [dbo].[spAddOrderDetails]
GO
/****** Object:  StoredProcedure [dbo].[spAddOrder]    Script Date: 25-10-2021 18:16:39 ******/
DROP PROCEDURE [dbo].[spAddOrder]
GO
/****** Object:  StoredProcedure [dbo].[spAddAddress]    Script Date: 25-10-2021 18:16:39 ******/
DROP PROCEDURE [dbo].[spAddAddress]
GO
/****** Object:  StoredProcedure [dbo].[spAddAddress]    Script Date: 25-10-2021 18:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- CREATE OR ALTER PROCEDURE spCheckUserExist
--     @UserId INT
-- AS
-- BEGIN

--     BEGIN TRY 

--     DECLARE @UserCount INT;

--     SELECT @UserCount=COUNT(UserId)
--     FROM [User]
--     WHERE UserId = @UserId

--     IF(@UserCount = 0)
--     BEGIN
--         PRINT 1
--         RETURN 1
--     END
--     ELSE
--        PRINT 2
--     BEGIN
--         RETURN 0
--     END

--     END TRY
--     BEGIN CATCH
--         DECLARE @ErrorMessage NVARCHAR(4000);
--         DECLARE @ErrorSeverity INT;
--         DECLARE @ErrorState INT;

--         SELECT
--             @ErrorMessage = ERROR_MESSAGE(),
--             @ErrorSeverity = ERROR_SEVERITY(),
--             @ErrorState = ERROR_STATE();

--         RAISERROR (@ErrorMessage,
--                 @ErrorSeverity, 
--                 @ErrorState 
--                 );
--     END CATCH
-- END
-- GO

-- EXEC spCheckUserExist 1

CREATE   PROCEDURE [dbo].[spAddAddress]
    @UserId INT,
    @Address VARCHAR(30)
AS
BEGIN
    BEGIN TRY
     
    DECLARE @IsUserExist INT;
    
    EXEC @IsUserExist = spCheckUserExist @UserId

    IF(@IsUserExist = 1)
    BEGIN
        RAISERROR('User not found',16,1)
    END

    BEGIN TRAN InsertAddress

    INSERT INTO ShippingAddress
        ([Address])
    VALUES(@Address)

    IF(@@ROWCOUNT = 0)
    BEGIN
        ROLLBACK TRAN InsertAddress;
        RAISERROR('Could not add address',16,1)
    END

    COMMIT TRAN InsertAddress

    RETURN 1

    END TRY
    BEGIN CATCH
       DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage,
                @ErrorSeverity, 
                @ErrorState 
                );
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spAddOrder]    Script Date: 25-10-2021 18:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spAddOrder]
    @UserId INT,
    @ShippingAddressId INT
AS
BEGIN
    BEGIN TRY

        DECLARE @NewOrderId INT;

        BEGIN TRAN AddOrder

        INSERT INTO [Order]
            (UserId,ShippingAddressId,CreatedAt,DeliveryDate,IsCancelled)
        VALUES
            (@UserId,@ShippingAddressId,GETDATE(),(GETDATE() + 5),0)

        IF(@@ROWCOUNT = 0)
            RAISERROR('Could not add order',16,1)
        
        SELECT @NewOrderId = SCOPE_IDENTITY();       

        COMMIT TRAN AddOrder

        RETURN @NewOrderId

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage,
                @ErrorSeverity, 
                @ErrorState 
                );
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spAddOrderDetails]    Script Date: 25-10-2021 18:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[spAddOrderDetails]
    @OrderId INT,
    @ProductId INT,
    @Quantity INT
AS
BEGIN
    BEGIN TRY

        DECLARE @Price SMALLMONEY;
        DECLARE @IsProductAvailable BIT;

        EXEC @IsProductAvailable = spCheckProductAvailability @ProductId,@Quantity;

        IF(@IsProductAvailable = 0)
            RAISERROR('Product quantity is low',16,1)

        SELECT @Price = Price
        FROM Product
        WHERE ProductId = @ProductId

        BEGIN TRAN AddOrderDetail

        Update Product SET ProductInHand = ProductInHand - @Quantity WHERE ProductId = @ProductId

        INSERT INTO OrderDetail
            (OrderId,ProductId,Quantity,OrderPrice,IsCancelled)
        VALUES
            (@OrderId, @ProductId, @Quantity, @Price, 0)

        IF(@@ROWCOUNT = 0)
            RAISERROR('Could not add order',16,1)

        COMMIT TRAN AddOrderDetail

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage,
                @ErrorSeverity, 
                @ErrorState 
                );
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spAddStock]    Script Date: 25-10-2021 18:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[spAddStock]
    @ProductId INT,
    @Stock INT
AS
BEGIN
    BEGIN TRY

        BEGIN TRAN InsertStock

        UPDATE Product SET ProductInHand = ProductInHand + @Stock WHERE ProductId = @ProductId

        IF(@@ROWCOUNT = 0)
            RAISERROR('Could not update the stock',16,1)

        COMMIT TRAN InsertStock

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage,
                @ErrorSeverity, 
                @ErrorState 
                );
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spAddUser]    Script Date: 25-10-2021 18:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- CREATE OR ALTER PROCEDURE spCheckMailExist
--     @MailID VARCHAR(30)
-- AS
-- BEGIN
--     BEGIN TRY

--     DECLARE @UserCount INT; 

--         SELECT @UserCount=COUNT(UserId)
--     FROM [User]
--     WHERE MailId = @MailID

--     IF(@UserCount = 0)
--     BEGIN
--         PRINT 1
--         RETURN 1
--     END
--     ELSE
--     BEGIN
--         RETURN 0
--     END

--     END TRY
--     BEGIN CATCH
--     DECLARE @ErrorMessage NVARCHAR(4000);
--     DECLARE @ErrorSeverity INT;
--     DECLARE @ErrorState INT;

--     SELECT
--         @ErrorMessage = ERROR_MESSAGE(),
--         @ErrorSeverity = ERROR_SEVERITY(),
--         @ErrorState = ERROR_STATE();

--     RAISERROR (@ErrorMessage,
--                @ErrorSeverity, 
--                @ErrorState 
--                );
--     END CATCH
-- END
-- GO

-- EXEC spCheckMailExist 'test2@test.com'

--To Check role exist

-- CREATE OR ALTER PROCEDURE spCheckRoleExist
--     @RoleId TINYINT
-- AS
-- BEGIN
--     BEGIN TRY
--         DECLARE @RoleCount TINYINT;

--         SELECT @RoleCount = COUNT(RoleId)
--         FROM [Role]
--         WHERE RoleId = @RoleId 

--         IF(@RoleCount = 1)
--         BEGIN
--         PRINT '1'
--             Return 1; 
--         END
--         PRINT '2'
        
--         RETURN 0;

--     END TRY
--     BEGIN CATCH
--     DECLARE @ErrorMessage NVARCHAR(4000);
--     DECLARE @ErrorSeverity INT;
--     DECLARE @ErrorState INT;

--     SELECT
--         @ErrorMessage = ERROR_MESSAGE(),
--         @ErrorSeverity = ERROR_SEVERITY(),
--         @ErrorState = ERROR_STATE();

--     RAISERROR (@ErrorMessage, 
--                @ErrorSeverity,
--                @ErrorState 
--                );
--     END CATCH
-- END
-- GO

-- EXEC spCheckRoleExist 4

--To Add User

CREATE   PROCEDURE [dbo].[spAddUser]
    @FirstName VARCHAR(18),
    @LastName VARCHAR(18),
    @DOB DATE,
    @MailId VARCHAR(30),
    @RoleId INT
AS
BEGIN
    DECLARE @IsMailIdFound INT;
    DECLARE @UserId INT;
    DECLARE @IsRoleExist INT;
    BEGIN TRY
        EXEC @IsMailIdFound = [spCheckMailExist] @MailId 
        EXEC @IsRoleExist = spCheckRoleExist @RoleId

        IF(@IsMailIdFound = 0)
        BEGIN
            RAISERROR('Username exists',16,6);
        END

        IF(@IsRoleExist = 0)
        BEGIN
            RAISERROR('Invalid Role',16,6);
        END

        BEGIN TRANSACTION InsertUser

        INSERT INTO [User]
            (
            [FirstName],[LastName],[DOB],[MailId],[IsActive],[CreatedAt],[RoleId]
            )
        VALUES
            (
                @FirstName, @LastName, @DOB, @MailId, 1, GETDATE(), @RoleId
            )

        IF(@@ROWCOUNT = 0)
        BEGIN
            ROLLBACK TRANSACTION InsertUser;
            RAISERROR('Cannot add user',16,6)
        END

        COMMIT TRANSACTION InsertUser

    END TRY
    BEGIN CATCH
    
    -- ROLLBACK TRANSACTION InsertUser;

    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    RAISERROR (@ErrorMessage,
               @ErrorSeverity,
               @ErrorState
               );
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spCancelOrder]    Script Date: 25-10-2021 18:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spCancelOrder]
    @CustomerId INT,
    @OrderId INT
AS
BEGIN
    BEGIN TRY
       
       DECLARE @IsOrderExist INT;
       DECLARE @OrderDetailCount INT;
       DECLARE @ProductId INT;
       DECLARE @Stock INT;
       DECLARE @OrderDetail TABLE(
        RowId INT IDENTITY(1,1),
        OrderDetailId INT,
        ProductId INT,
        Quantity INT
        );

        SELECT @IsOrderExist = COUNT(OrderId)
    FROM [Order]
    WHERE UserId = @CustomerId

        IF(@IsOrderExist = 0)
            RAISERROR('Order doesnt exist',16,1);

        INSERT INTO @OrderDetail
    SELECT OrderDetailId, ProductId, Quantity
    FROM OrderDetail
    WHERE OrderId = @OrderId

        SELECT *
    FROM @OrderDetail

        SELECT @OrderDetailCount = COUNT(OrderDetailId)
    From @OrderDetail

        WHILE(@OrderDetailCount>0)
        BEGIN
        SELECT @ProductId = ProductId, @Stock = Quantity
        FROM @OrderDetail
        WHERE RowId = @OrderDetailCount

        SELECT @OrderDetailCount = @OrderDetailCount - 1

        -- Print @OrderDetailCount

        -- select @ProductId,@Stock,@OrderDetailCount

        EXEC spAddStock @ProductId,@Stock
    END
        
        -- UPDATE [Order] SET IsCancelled = 

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage,
                @ErrorSeverity, 
                @ErrorState 
                );
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spCheckMailExist]    Script Date: 25-10-2021 18:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spCheckMailExist]
    @MailID VARCHAR(30)
AS
BEGIN
    BEGIN TRY

    DECLARE @UserCount INT; 

        SELECT @UserCount=COUNT(UserId)
    FROM [User]
    WHERE MailId = @MailID

    IF(@UserCount = 0)
    BEGIN
        PRINT 1
        RETURN 1
    END
    ELSE
    BEGIN
        RETURN 0
    END

    END TRY
    BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    RAISERROR (@ErrorMessage,
               @ErrorSeverity, 
               @ErrorState 
               );
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spCheckProductAvailability]    Script Date: 25-10-2021 18:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spCheckProductAvailability]
    @ProductId INT,
    @Quantity INT
AS
BEGIN
    BEGIN TRY

        DECLARE @ProductInHand INT;
        DECLARE @IsProductAvailable BIT;

        SELECT @ProductInHand = ProductInHand from Product;

        Print @ProductInHand

        IF(@ProductInHand > @Quantity)
        BEGIN
            Print 'Productinhand>quant'
            RETURN 1
        END
        ELSE
        BEGIN
            Print 'Productinhand<quant'
            RETURN 1
        END

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage,
                @ErrorSeverity, 
                @ErrorState 
                );
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spCheckRoleExist]    Script Date: 25-10-2021 18:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC spCheckMailExist 'test2@test.com'

--To Check role exist

CREATE   PROCEDURE [dbo].[spCheckRoleExist]
    @RoleId TINYINT
AS
BEGIN
    BEGIN TRY
        DECLARE @RoleCount TINYINT;

        SELECT @RoleCount = COUNT(RoleId)
        FROM [Role]
        WHERE RoleId = @RoleId 

        IF(@RoleCount = 1)
        BEGIN
        PRINT '1'
            Return 1; 
        END
        PRINT '2'
        
        RETURN 0;

    END TRY
    BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    RAISERROR (@ErrorMessage, 
               @ErrorSeverity,
               @ErrorState 
               );
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spCheckUserExist]    Script Date: 25-10-2021 18:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spCheckUserExist]
    @UserId INT
AS
BEGIN

    BEGIN TRY 

    DECLARE @UserCount INT;

    SELECT @UserCount=COUNT(UserId)
    FROM [User]
    WHERE UserId = @UserId

    IF(@UserCount = 0)
    BEGIN
        PRINT 1
        RETURN 1
    END
    ELSE
       PRINT 2
    BEGIN
        RETURN 0
    END

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage,
                @ErrorSeverity, 
                @ErrorState 
                );
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spGetAllOrder]    Script Date: 25-10-2021 18:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spGetAllOrder]
AS
BEGIN
    BEGIN TRY
        SELECT O.OrderId, O.UserId, U.FirstName, U.LastName, O.ShippingAddressId, SA.ShippingAddressId, O.CreatedAt, O.DeliveryDate, O.IsCancelled, OD.OrderDetailId, P.ProductId, P.ProductName, OD.Quantity, OD.OrderPrice, OD.IsCancelled AS ProductIsCancelled
    FROM [Order] O
        INNER JOIN OrderDetail OD ON OD.OrderId = O.OrderId
        INNER JOIN ShippingAddress SA ON SA.ShippingAddressId = O.ShippingAddressId
        INNER JOIN Product P ON P.ProductId = OD.ProductId
        INNER JOIN [User] U ON U.UserId = O.UserId

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage,
                @ErrorSeverity, 
                @ErrorState 
                );
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spGetCustomerOrder]    Script Date: 25-10-2021 18:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spGetCustomerOrder]
@CustomerId INT
AS
BEGIN
    BEGIN TRY
        SELECT O.OrderId, O.UserId, U.FirstName, U.LastName, O.ShippingAddressId, SA.ShippingAddressId, O.CreatedAt, O.DeliveryDate, O.IsCancelled, OD.OrderDetailId, P.ProductId, P.ProductName, OD.Quantity, OD.OrderPrice, OD.IsCancelled AS ProductIsCancelled
    FROM [Order] O
        INNER JOIN OrderDetail OD ON OD.OrderId = O.OrderId
        INNER JOIN ShippingAddress SA ON SA.ShippingAddressId = O.ShippingAddressId
        INNER JOIN Product P ON P.ProductId = OD.ProductId
        INNER JOIN [User] U ON U.UserId = O.UserId
        WHERE U.UserId = @CustomerId

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage,
                @ErrorSeverity, 
                @ErrorState 
                );
    END CATCH
END
GO
