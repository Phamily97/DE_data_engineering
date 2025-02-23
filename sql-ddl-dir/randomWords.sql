CREATE TABLE randomWords 
     (
        word varchar(50) NOT NULL
     )
BULK INSERT randomWords FROM '---' WITH (FORMAT='CSV')
GO
