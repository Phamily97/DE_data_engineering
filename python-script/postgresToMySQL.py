from sqlalchemy import create_engine
from sqlalchemy import Table
from sqlalchemy import MetaData
from sqlalchemy import select, func
from datetime import datetime
from dotenv import load_dotenv
import os

try:
    dir = 'C:/Users/User/OneDrive/Documents/config'
    env_path = os.path.join(dir, '.env')
    load_dotenv(dotenv_path=env_path)

    pg_user = os.getenv("PG_DB_USER")
    pg_password = os.getenv("PG_DB_PASSWORD")
    pg_host = os.getenv("PG_DB_HOST")
    pg_db = os.getenv("PG_DB_NAME")

    psql_engine = create_engine(f"postgresql+psycopg2://{pg_user}:{pg_password}@{pg_host}/{pg_db}")

    metadata = MetaData()

    audit_log = Table(
        'audit_log'
        ,metadata
        ,autoload_with=psql_engine
    )

    query = select(audit_log)

    # on migrate succ, sync
    with psql_engine.begin() as conn:
        print("succ")
        # stmt = func.sync_audit_table('products', datetime.now())
        # result = conn.execute(stmt)
        
except IOError:
    print("Unexpected Error")
