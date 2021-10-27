
 
 CREATE OR ALTER PROCEDURE spCheckMailExist
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

-- EXEC spCheckMailExist 'test2@test.com'

--To Check role exist

 CREATE OR ALTER PROCEDURE spCheckRoleExist
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

-- EXEC spCheckRoleExist 4

--To Add User

CREATE OR ALTER PROCEDURE spAddUser
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

-- EXEC spAddUser 'Harry','Potter','2000-12-24','test42@test.com',2


--To check user exists
CREATE OR ALTER PROCEDURE spCheckUserExist
    @UserId INT
AS
BEGIN

   -- BEGIN TRY 

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

  --  END TRY
  /*  BEGIN CATCH
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
    END CATCH */
END
GO

-- EXEC spCheckUserExist 1

-- To add Shipping address

CREATE OR ALTER PROCEDURE spAddAddress
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
        (UserId,[Address])
    VALUES(@UserId, @Address)

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

-- EXEC spAddAddress 2,'asdfjsdkfjsdlfjlasdjfklsdf'

-- to add category

CREATE OR ALTER PROCEDURE spAddCategory
    @CategoryName VARCHAR(20)
AS
BEGIN
    BEGIN TRY

        BEGIN TRAN InsertCategory

        INSERT INTO Category
        (CategoryName)
        VALUES(@CategoryName)

        IF(@@ROWCOUNT = 0)
            RAISERROR('Could not insert category',16,1)

        COMMIT TRAN InsertCategory

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

-- To add products


CREATE OR ALTER PROCEDURE spAddProduct
    @ProductName VARCHAR(20),
    @ProductInHand INT,
    @Price SMALLMONEY,
    @CategoryId INT
AS
BEGIN
    BEGIN TRY

        BEGIN TRAN InsertProduct

        INSERT INTO Product
        (ProductName,ProductInHand,ProductOnOrder,Price,PriceUpdatedAt,CategoryId,IsActive)
        VALUES(@ProductName, @ProductInHand, 0, @Price, GETDATE(), @CategoryId,1)

        IF(@@ROWCOUNT = 0)
            RAISERROR('Could not insert product',16,1)

        COMMIT TRAN InsertProduct

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

-- EXEC spAddProduct 'potato',100,1000,2

-- to increase stock
CREATE OR ALTER PROCEDURE spAddStock
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

-- EXEC spAddStock 23,10

-- to update price
CREATE OR ALTER PROCEDURE spUpdatePrice
    @ProductId INT,
    @Price SMALLMONEY
AS
BEGIN
    BEGIN TRY

        BEGIN TRAN UpdatePrice

        UPDATE Product SET Price = @Price,PriceUpdatedAt = GETDATE() WHERE ProductId = @ProductId

        IF(@@ROWCOUNT = 0)
            RAISERROR('Could not update the price',16,1)

        COMMIT TRAN UpdatePrice

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

-- EXEC spUpdatePrice 23,13000

-- to add new order
CREATE OR ALTER PROCEDURE spAddOrder
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

-- to check the product is available or not

CREATE OR ALTER PROCEDURE spCheckProductAvailability
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

-- EXEC spCheckProductAvailability 2,1	
-- to add order details


CREATE OR ALTER PROCEDURE spAddOrderDetails
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

        IF(@Price IS NULL)
            RAISERROR('Could not find the product',16,1)

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

-- EXEC spAddOrderDetails 9,24,2

-- to remove order  not completed yet
CREATE OR ALTER PROCEDURE spCancelOrder
    @OrderId INT,
	@CustomerId INT = NUll
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

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[spCancelOrder]
    @OrderId INT,
	@CustomerId INT = NUll,

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

        IF(@ProductId IS NOT NULL)
            EXEC spAddStockByCancel @ProductId,@Stock
            Update [Order] SET IsCancelled = 1 WHERE OrderId = @OrderId

            -- IF(@@ROWCOUNT > 0)
                -- COMMIT TRAN Can

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


--Get Products

CREATE PROC uspGetProduct
as 
BEGIN
	Select ProductId
	,CategoryId
	,ProductName
	,ProductInHand
	,ProductOnOrder
	,Price
	,PriceUpdatedAt
	,IsActive
	from Product
END

exec uspGetProduct
GO


--Get Cart Items

CREATE PROC uspGetCartItem
@ID int
as 
BEGIN
		Select ProductId
	,CategoryId
	,ProductName
	,ProductInHand
	,ProductOnOrder
	,Price
	,PriceUpdatedAt
	,IsActive
	from Product
	where ProductId  = @ID
END
GO
--Create Order

CREATE PROC uspCreateOrder
@IsCancelled bit = 'false'
as
BEGIN
	Insert Into [Order]( CreatedAt,DeliveryDate,IsCancelled)
	Values(GetDate(),GetDate() + 5, @IsCancelled)


END
GO


-- Get OrderID
CREATE PROC uspGetOrderId
@UserId int
as
BEGIN
	Select OrderId
	from [Order]
	where CreatedAt = CAST(GetDate() as Date)
END
GO

--Insert OrderDeatail

CREATE PROC uspOrderDetail
@OrderID int,
@ProductID int,
@Count int,
@Price money
as
BEGIN
	Insert Into [OrderDetail] ( OrderId, ProductId, Quantity, OrderPrice)
	Values ( @OrderId, @ProductID, @Count, @Price)
END
GO



--Get User by ID

CREATE PROC uspGetUserByEmail
@Email varchar(50)
as
BEGIN
	Select U.UserId
	,U.FirstName
	,S.ShippingAddressId
	from [User] U
	join ShippingAddress S
	on U.UserId = S.UserId AND U.MailId = @Email
END
GO


--Cretae Order

CREATE OR ALTER PROCEDURE uspAddOrder
    @UserId INT = NULL,
    @ShippingAddressId INT = NULL
AS
BEGIN

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
		print(@NewOrderId)

        RETURN @NewOrderId


END

exec uspAddOrder

CREATE PROC uspAddOrderDetail
@OrderId int,
@ProductId int
as
BEGIN
	BEGIN TRY
	BEGIN Tran
		if(@ProductId IS NULL)
		BEGIN
			RAISERROR('ProductId should not be null',16,1)
		END
		DECLARE @ProdCount int;

		Set @ProdCount = (Select Count(ProductId)
							from OrderDetail
							Where OrderId = @OrderId
							)

		if (@ProdCount > 1)
		BEGIN
			Update OrderDetail
			Set Quantity = Quantity + 1
			where OrderId = @OrderId AND ProductId = @ProductId

			Update Product
			Set ProductInHand = ProductInHand - 1
			Where ProductId = @ProductId
		END
		ElSE
		BEGIN
			Insert Into OrderDetail(OrderId, ProductId, Quantity, IsCancelled)
			Values(@OrderId, @ProductId,1,0)

			Update Product
			Set ProductInHand = ProductInHand - 1
			Where ProductId = @ProductId
		END

		Commit Tran
	END TRY
	BEGIN CATCH
		Delete OrderDetail
		Where OrderId = @OrderId

		Delete [Order]
		Where OrderId = @OrderId

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






