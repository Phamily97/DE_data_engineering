from sqlalchemy import create_engine
from sqlalchemy import Table, MetaData, text
import os
from dotenv import load_dotenv
from fastapi import FastAPI
import uvicorn

app = FastAPI()
@app.get("/")
def read():
    dir = 'C:/Users/User/OneDrive/Documents/config'
    env_path = os.path.join(dir, '.env')
    load_dotenv(dotenv_path=env_path)

    mysql_pg_user = os.getenv("MYSQL_DB_USER")
    mysql_pg_password = os.getenv("MYSQL_DB_PASSWORD")
    mysql_pg_host = os.getenv("MYSQL_DB_HOST")
    mysql_pg_db = os.getenv("MYSQL_DB_NAME")

    engine = create_engine(f'mysql+pymysql://{mysql_pg_user}:{mysql_pg_password}@{mysql_pg_host}:3306/{mysql_pg_db}')

    with engine.connect() as conn:
        result = conn.execute(
            text("CALL spGet_audit_log(:page_number,:max_row,:table_name)"),
            {
            "page_number": 1,
            "max_row": 10,
            "table_name": "products"
        }
        )
        
        rows = result.mappings().all()
        result.close()

        return {"data": rows}
        
if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="127.0.0.1", port=8080, reload=True)