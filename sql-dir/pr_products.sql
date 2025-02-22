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