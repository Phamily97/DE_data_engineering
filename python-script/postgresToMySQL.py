from sqlalchemy import create_engine
from sqlalchemy import Table
from sqlalchemy import MetaData
from sqlalchemy import select, func
from datetime import datetime
from dotenv import load_dotenv
import os
import pandas as py
import sqlalchemy

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

    with psql_engine.begin() as psql_conn:

        audit_log = Table(
            'audit_log'
            ,metadata
            ,autoload_with=psql_engine
        )

        audit_sync = Table(
            'audit_sync'
            ,metadata
            ,autoload_with=psql_engine
        )

        current_sync = select(audit_sync.columns.last_sync).where(audit_sync.columns.table_name == 'products')
        check_current_sync = psql_conn.execute(current_sync).scalar()

        # first run will ship all
        if check_current_sync is None:
            query = select(audit_log)
        else:
            query = select(audit_log).where(audit_log.columns.changed_at > current_sync)

        psql_res = psql_conn.execute(query).fetchall()
        df = py.DataFrame(psql_res)

        if len(df) > 0:
            df['operation_type_denom'] = df['operation_type'].apply(lambda x: 'Insert' if x == 1 else ('Delete' if x == 4 else 'Updated'))
            
            mysql_pg_user = os.getenv("MYSQL_DB_USER")
            mysql_pg_password = os.getenv("MYSQL_DB_PASSWORD")
            mysql_pg_host = os.getenv("MYSQL_DB_HOST")
            mysql_pg_db = os.getenv("MYSQL_DB_NAME")

            mysql_engine = create_engine(f'mysql+mysqlconnector://{mysql_pg_user}:{mysql_pg_password}@{mysql_pg_host}:3306/{mysql_pg_db}')

            try:
                df.to_sql(
                    'audit_log'
                    , mysql_engine
                    , index=False
                    , if_exists='append'
                    , dtype={'changed_data': sqlalchemy.types.JSON}
                    )
                stmt = func.sync_audit_table('products', datetime.now())
                result = psql_conn.execute(stmt)
            except IOError:
                print("Unexpected Error")
except IOError:
    print("Unexpected Error")
