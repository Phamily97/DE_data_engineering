CREATE TABLE public.audit_log (
	audit_log_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
    ,table_name NVARCHAR(255) NOT NULL
	,operation_type SMALLINT NOT NULL
	,link_id INT NULL
	,changed_data JSON
	,changed_at DATETIME
    ,operation_type_denom NVARCHAR(10) NOT NULL
);