CREATE TABLE audit_sync(
	audit_sync_id INT GENERATED ALWAYS AS IDENTITY
	,table_name VARCHAR(255) NOT NULL
	,last_sync TIMESTAMP NULL
)

INSERT INTO audit_sync (table_name)
VALUES('products')