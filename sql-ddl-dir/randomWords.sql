CREATE TABLE randomWords 
     (
        word varchar(50) NOT NULL
     )
BULK INSERT randomWords FROM '---' WITH (FORMAT='CSV')
GO

ALTER TABLE randomWords ADD word_id INT IDENTITY(1,1) NOT NULL
GO