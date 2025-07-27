CREATE OR REPLACE FUNCTION sync_audit_table(
	table_name_var VARCHAR(255)
	,last_sync_time_var  TIMESTAMP
)
RETURNS TEXT
AS $$
BEGIN
	UPDATE audit_sync
	SET last_sync = CASE WHEN last_sync_time_var < last_sync THEN last_sync ELSE last_sync_time_var END
	WHERE table_name = table_name_var;
	RETURN 'OK';
END;
$$
LANGUAGE plpgsql;