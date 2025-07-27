CREATE TABLE audit_log (
	table_name VARCHAR(255) NOT NULL
	,operation_type SMALLINT NOT NULL
	,link_id INT NULL --id for linking updated data
	,changed_data JSONB
	,changed_at TIMESTAMP
)

--query for restarting pipeline. Testing only
UPDATE audit_sync
SET last_sync = NULL
WHERE audit_sync_id = 1