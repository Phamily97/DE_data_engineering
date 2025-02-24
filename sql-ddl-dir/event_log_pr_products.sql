--TODO: Add in product_id reference and adjust trigger
CREATE TABLE event_log_pr_products (
	event_log_id INT IDENTITY(1,1)
	,event NVARCHAR(MAX) NULL
	,event_type INT NOT NULL
	,event_time_UTC DATETIME2(7) NOT NULL CONSTRAINT DF_event_log_pr_products_event_time_UTC DEFAULT GETUTCDATE()
)