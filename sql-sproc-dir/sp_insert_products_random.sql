/*
Basic generator for pr_products
TODO: Make random generation dynamic
*/
CREATE OR ALTER PROCEDURE sp_insert_products_random (
	@max_row INT = 0
)
AS SET NOCOUNT ON
BEGIN
	
DECLARE @ProductName NVARCHAR(255) = ''
	,@Qty INT = 0
	,@CostEx DECIMAL = 0
	,@SellEX DECIMAL = 0
	,@Tax DECIMAL = 0
	,@type_id INT = 0
	,@Last_updated_UTC DATETIME2 = GETUTCDATE()
	,@Status INT = 0
	,@iterator INT = 0

WHILE (@iterator < @max_row)
BEGIN
	DECLARE @Body NVARCHAR(MAX) = ''
	,@rand INT = 0
	,@randNumb INT = 0

	SET @rand = (SELECT FLOOR(RAND() * (100 - 1 + 1)) + 1)
	SET @randNumb = (SELECT FLOOR(RAND() * (10 - 1 + 1)) + 1)
	
	SELECT @ProductName = rw.word
	FROM randomWords rw
	WHERE rw.word_id = @rand

	SELECT @Qty = (SELECT FLOOR(RAND() * (10 - 1 + 1)) + 1) * @randNumb
		,@CostEx = CAST((SELECT FLOOR(RAND() * (10 - 1 + 1)) + 1) * @randNumb AS DECIMAL)
		,@Tax = @randNumb
		,@SellEX = CAST(@CostEx * (1 + (@Tax/100)) AS DECIMAL)

	SELECT @Qty
		,@CostEx
		,@Tax
		,@SellEX
	
	INSERT INTO pr_products (Product, Qty, CostEx, SellEx, Tax)
	SELECT @ProductName
		,@Qty
		,@CostEx
		,@SellEX
		,@Tax

	SET @iterator += 1
END
END
