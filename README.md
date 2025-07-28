This project serves as a playground for SQL and Python relating to Data Engineering.

Currently working on mocking PostgreSQL to MySQL End-to-end pipelines including:
  1. Simple ingestion pipeline for mock data
  2. Trigger to capture changes in postgreSQL table and logging it into an audit table
  3. ETL for moving audit data to MySQL instance            
  4. Function/Stored procedure to get data out of MySQL as JSON
  5. FastAPI to fetch data from audit table

Use Case:
Moving data to different storage solutions for performance/cost benefits.
