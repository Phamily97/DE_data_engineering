CREATE TABLE products (
	product_id INT GENERATED ALWAYS AS IDENTITY
	,product_name VARCHAR(255) NOT NULL
	,description VARCHAR(3000) NULL
	,refNo VARCHAR(255) NULL
	,serialNo VARCHAR(255) NULL
	,unit_cost FLOAT NOT NULL CONSTRAINT DF_products_unit_cost DEFAULT(0.0)
	,unit_sell FLOAT NOT NULL CONSTRAINT DF_products_unit_sell DEFAULT(0.0)
	,markup FLOAT NOT NULL CONSTRAINT DF_products_markup DEFAULT(0.0)
	,qty INT NOT NULL CONSTRAINT DF_products_qty DEFAULT(0)
	,tax FLOAT NOT NULL CONSTRAINT DF_products_tax DEFAULT(0.0)
	,type_id INT NOT NULL CONSTRAINT DF_products_type_id DEFAULT(0) 
	,is_archived BIT NOT NULL CONSTRAINT DF_products_is_archived DEFAULT(B'0')
)

CREATE INDEX IX_B_products_type_id_is_archived_product_id ON products 
(
	type_id ASC
	,is_archived ASC
	,product_id ASC
) INCLUDE(
	product_name
	,unit_cost
	,unit_sell
	,markup
	,qty
	,tax
)