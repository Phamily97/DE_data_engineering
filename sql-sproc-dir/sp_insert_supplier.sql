CREATE OR ALTER PROCEDURE sp_insert_supplier(
	@supplier_name NVARCHAR(255) = ''
	,@Contact NVARCHAR(255) = ''
	,@Email NVARCHAR(255) = ''
	,@Address NVARCHAR(255) = ''
	,@Country NVARCHAR(255) = ''
)
AS
BEGIN SET NOCOUNT ON;
	/*Checks for params*/

	

	IF (SELECT COUNT(1)
		FROM sup_supplier sup WITH (NOLOCK)
		WHERE sup.Contact LIKE LTRIM(RTRIM(@Contact))) > 0
	BEGIN
		; THROW 50000, 'Unavailable phone number', 1;
	END

	

	IF(SELECT COUNT(1)
		FROM sup_supplier sup WITH(NOLOCK)
		WHERE sup.Email LIKE LTRIM(RTRIM(@Email))) > 0
	BEGIN
		; THROW 50000, 'Unavailable email address', 1
	END

	INSERT INTO sup_supplier (Supplier_name, Contact, Email, Address, Country)
	VALUES (@supplier_name, @Contact, @Email, @Address, @Country)

	--Return 0 on sucessful insert
	IF @@ERROR <> 1
	BEGIN
		RETURN 0;
	END
	ELSE
	BEGIN
		RETURN 1;
	END
END
GO