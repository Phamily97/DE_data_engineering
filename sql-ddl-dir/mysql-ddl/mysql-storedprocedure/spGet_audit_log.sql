DELIMITER $$

CREATE PROCEDURE spGet_audit_log(
	IN page_number_in INT
    ,IN max_row_in INT
    ,IN table_name_in VARCHAR(255)
)
BEGIN
	DECLARE offset_val INT;
    SET offset_val = (page_number_in - 1) * max_row_in;

	SELECT 
		link_id
        ,changed_data
        ,changed_at
        ,operation_type_denom
    FROM audit_log
    WHERE table_name = table_name_in
    LIMIT max_row_in OFFSET offset_val;
END $$

DELIMITER ;