CREATE TABLE pr_products (
	Product_id INT IDENTITY(1,1)
	,Product NVARCHAR(255) CONSTRAINT DF_pr_products_Product NOT NULL
	,OrderNo NVARCHAR(50) NULL
	,Qty INT NOT NULL CONSTRAINT DF_pr_products_Qty DEFAULT(0)
	,CostEx DECIMAL NOT NULL CONSTRAINT DF_pr_products_CostEx DEFAULT(0)
	,SellEx DECIMAL NOT NULL CONSTRAINT DF_pr_products_SellEx DEFAULT(0)
	,Tax DECIMAL NOT NULL CONSTRAINT DF_pr_products_Tax DEFAULT(0)
	,Supplier_id INT NULL
	,type_id INT NOT NULL CONSTRAINT DF_pr_products_type_id DEFAULT(0)
	,expiration_date DATETIME2(7) NULL
	,country_id INT NULL
	,Last_updated_UTC DATETIME2(7) NOT NULL CONSTRAINT DF_pr_products_Last_updated_UTC DEFAULT(GETDATE()) 
)
/*Ticket: DP-7*/
ALTER TABLE pr_products ADD Status INT NOT NULL CONSTRAINT DF_pr_products_Status DEFAULT(0)
GO

ALTER TABLE pr_products ADD Status_computed AS (
	CASE WHEN status = 0 THEN 'Active'
		WHEN status = 1 THEN 'On-Hold'
		WHEN status = 2 THEN 'Inactive'
		WHEN status = 3 THEN 'Archive'
	END
) PERSISTED
GO

ALTER TABLE pr_products ADD type_computed AS (
	CASE WHEN type_id = 0 THEN 'Food & Drinks' 
		WHEN type_id = 1 THEN 'Clothing'
		WHEN type_id = 2 THEN 'Electronics'
		WHEN type_id = 3 THEN 'Equipment'
		WHEN type_id = 4 THEN 'Vehicle & Parts'
		WHEN type_id = 5 THEN 'Cosmetics'
		WHEN type_id = 6 THEN 'Everyday items'
		WHEN type_id = 7 THEN 'Gaming'
		WHEN type_id = 8 THEN 'Home Appliance'
		WHEN type_id = 9 THEN 'Music'
	END
) PERSISTED
GO
