USE [OrderManagementSystem]
GO
/****** Object:  StoredProcedure [dbo].[spCancelOrder]    Script Date: 27-10-2021 15:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- to remove order  not completed yet
CREATE   PROCEDURE [dbo].[spCancelOrder]
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
/****** Object:  StoredProcedure [dbo].[uspAddOrder]    Script Date: 27-10-2021 15:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[uspAddOrder]
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
GO
/****** Object:  StoredProcedure [dbo].[uspAddOrderDetail]    Script Date: 27-10-2021 15:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[uspAddOrderDetail]
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


GO
/****** Object:  StoredProcedure [dbo].[uspCreateOrder]    Script Date: 27-10-2021 15:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspCreateOrder]
@IsCancelled bit = 'false'
as
BEGIN
	Insert Into [Order]( CreatedAt,DeliveryDate,IsCancelled)
	Values(GetDate(),GetDate() + 5, @IsCancelled)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetCartItem]    Script Date: 27-10-2021 15:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetCartItem]
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
/****** Object:  StoredProcedure [dbo].[uspGetOrderId]    Script Date: 27-10-2021 15:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetOrderId]
@UserId int
as
BEGIN
	Select OrderId
	from [Order]
	where CreatedAt = CAST(GetDate() as Date)
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetProduct]    Script Date: 27-10-2021 15:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspGetProduct]
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
GO
/****** Object:  StoredProcedure [dbo].[uspGetUserByEmail]    Script Date: 27-10-2021 15:54:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[uspGetUserByEmail]
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
