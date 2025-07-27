import pandas as py
from sqlalchemy import create_engine
import os
from dotenv import load_dotenv

dir = 'C:/Users/User/OneDrive/Documents/GitHub/DE_data_engineering/'

df = py.read_csv(f'{dir}new_products_26072025.txt')

# default NaN for NOT NULL columns
df['unit_cost'] = df['unit_cost'].fillna(0)
df['unit_sell'] = df['unit_sell'].fillna(0)
df['markup']= df['markup'].fillna(0)
df['qty'] = df['qty'].fillna(0)
df['tax'] = df['tax'].fillna(0)
df['type_id'] = df['type_id'].fillna(0)

import_exi = df.columns
not_exi = True
for x in import_exi:
    if(x == 'has_imported'):
        not_exi = False
        break

# requires specific formatted CSV/text file
if not_exi:
    env_dir = 'C:/Users/User/OneDrive/Documents/config'
    env_path = os.path.join(env_dir, '.env')
    load_dotenv(dotenv_path=env_path)

    pg_user = os.getenv("PG_DB_USER")
    pg_password = os.getenv("PG_DB_PASSWORD")
    pg_host = os.getenv("PG_DB_HOST")
    pg_db = os.getenv("PG_DB_NAME")

    engine = create_engine(f"postgresql+psycopg2://{pg_user}:{pg_password}@{pg_host}/{pg_db}")
    try:
        df.to_sql('products', engine, index=False, if_exists='append')
        df['has_imported'] = 1
        df.to_csv(f'{dir}imported_new_products_26072025.txt', mode='w')
    except IOError:
        print('Unexpected Error')