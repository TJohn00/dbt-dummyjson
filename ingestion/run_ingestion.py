from ingestion.load import *
from ingestion.extract import *

def extract_load_data(extract,load,conn):
    extracted_data = extract()
    load(extracted_data,conn)
    print(f"Extract load completed for {extract}")


def run():
    actions = [[fetch_products,load_products],[fetch_categories,load_categories],[fetch_users,load_users],[fetch_carts,load_carts]]
    db_conn = get_con()
    create_schema(db_conn)
    for action in actions:
        extract_load_data(action[0],action[1],db_conn)
    close_con(db_conn)

run()