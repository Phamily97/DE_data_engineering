--trigger to mock CDC
CREATE OR REPLACE FUNCTION products_audit()
    RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO audit_log (table_name, operation_type, changed_data, changed_at)
            VALUES (TG_TABLE_NAME, 1, to_jsonb(NEW), NOW());
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
			--insert old entry
            INSERT INTO audit_log (table_name, operation_type, link_id, changed_data, changed_at)
            VALUES (
				TG_TABLE_NAME
				, 3
				,(SELECT audit_log_link())
				,(SELECT jsonb_agg(
					jsonb_strip_nulls(jsonb_build_object(
						'unit_cost', (SELECT CASE WHEN OLD.unit_cost <> NEW.unit_cost THEN OLD.unit_cost ELSE NULL END)
						,'unit_sell', (SELECT CASE WHEN OLD.unit_sell <> NEW.unit_sell THEN OLD.unit_sell ELSE NULL END)
						,'description', (SELECT CASE WHEN (SELECT COALESCE(OLD.description, 'NULL')) <> NEW.description THEN OLD.description ELSE 'NULL' END)
						,'refNo', (SELECT CASE WHEN OLD.refNo <> NEW.refNo THEN OLD.refNo ELSE NULL END)
						,'qty', (SELECT CASE WHEN OLD.qty <> NEW.qty THEN OLD.qty ELSE NULL END)
						))
					)
				)
				, NOW()
				);

				--insert new entry
				INSERT INTO audit_log (table_name, operation_type, link_id, changed_data, changed_at)
	            VALUES (
					TG_TABLE_NAME
					, 4
					,(SELECT audit_log_link()) - 1
					,(SELECT jsonb_agg(
						jsonb_strip_nulls(jsonb_build_object(
							'unit_cost', (SELECT CASE WHEN OLD.unit_cost <> NEW.unit_cost THEN NEW.unit_cost ELSE NULL END)
							,'unit_sell', (SELECT CASE WHEN OLD.unit_sell <> NEW.unit_sell THEN NEW.unit_sell ELSE NULL END)
							,'description', (SELECT CASE WHEN (SELECT COALESCE(OLD.description, 'NULL')) <> NEW.description THEN NEW.description ELSE 'NULL' END)
							,'refNo', (SELECT CASE WHEN OLD.refNo <> NEW.refNo THEN NEW.refNo ELSE NULL END)
							,'qty', (SELECT CASE WHEN OLD.qty <> NEW.qty THEN NEW.qty ELSE NULL END)
							))
						)
					)
					, NOW()
					)
				;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO audit_log (table_name, operation_type, changed_data, changed_at)
            VALUES (TG_TABLE_NAME, 2, to_jsonb(OLD), NOW());
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;