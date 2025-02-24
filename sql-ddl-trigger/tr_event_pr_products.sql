CREATE OR ALTER TRIGGER tr_event_pr_products ON pr_products
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @operation TINYINT = 0

	SET @operation = 
		CASE
			--INSERTED operation
			WHEN (SELECT COUNT(1) FROM INSERTED) > 0 AND (SELECT COUNT(1) FROM DELETED) = 0
				THEN 1
			--DELETE opeartion
			WHEN (SELECT COUNT(1) FROM INSERTED) = 0 AND (SELECT COUNT(1) FROM DELETED) > 0
				THEN 2
			--UPDATE operation
			ELSE 3
		END

	IF @operation = 1
	BEGIN
		INSERT INTO event_log_pr_products(event, event_type)
			SELECT json_obj.json_obj
				,@operation
			FROM (SELECT (SELECT Product AS Product
			,OrderNo AS OrderNo
			,Qty AS Qty
			,CostEx AS CostEx
			,SellEx AS SellEx
			,Tax AS Tax
			,expiration_date AS expiration_date
			,Status AS Status
			,Last_updated_UTC AS Last_updated_UTC
		FROM INSERTED i
		FOR JSON PATH, ROOT('ins')) json_obj) json_obj
	END
	
	IF @operation = 2
	BEGIN
		INSERT INTO event_log_pr_products(event, event_type)
			SELECT json_obj.json_obj
				,@operation
			FROM (SELECT (SELECT Product AS Product
			,OrderNo AS OrderNo
			,Qty AS Qty
			,CostEx AS CostEx
			,SellEx AS SellEx
			,Tax AS Tax
			,expiration_date AS expiration_date
			,Status AS Status
			,Last_updated_UTC AS Last_updated_UTC
		FROM DELETED d
		FOR JSON PATH, ROOT('del')) json_obj) json_obj
	END

	IF @operation = 3
	BEGIN
		INSERT INTO event_log_pr_products(event, event_type)
			SELECT json_obj.json_obj
				,@operation
			FROM (SELECT (
			SELECT NULLIF(i.Product, d.Product) AS Product
				,NULLIF(i.OrderNo, d.OrderNo) AS OrderNo
				,NULLIF(i.Qty, d.Qty) AS Qty
				,NULLIF(i.CostEx, d.CostEx) AS CostEx
				,NULLIF(i.SellEx, d.SellEx) AS SellEx
				,NULLIF(i.Tax, d.Tax) AS Tax
				,NULLIF(i.expiration_date, d.expiration_date) AS expiration_date
				,NULLIF(i.Status, d.Status) AS Status
				,NULLIF(i.Last_updated_UTC, d.Last_updated_UTC) AS Last_updated_UTC
			FROM INSERTED i
			OUTER APPLY (SELECT Product AS Product
				,OrderNo AS OrderNo
				,Qty AS Qty
				,CostEx AS CostEx
				,SellEx AS SellEx
				,Tax AS Tax
				,expiration_date AS expiration_date
				,Status AS Status
				,Last_updated_UTC AS Last_updated_UTC
			FROM DELETED d) d
			FOR JSON PATH, ROOT('upd')
			) json_obj) json_obj
	END
END
