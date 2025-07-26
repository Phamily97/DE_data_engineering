--generate the next linking_id for audit_log table to connect updated transactions. This mocks CDC operation 3,4
CREATE OR REPLACE FUNCTION audit_log_link()
RETURNS INT
AS $$
BEGIN
	RETURN COALESCE(MAX(link_id), 0) + 1
	FROM audit_log;
END;
$$ LANGUAGE plpgsql;