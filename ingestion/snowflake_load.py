import snowflake.connector as sc
import json
import pandas as pd
from ingestion.snowflake_config import SNOWFLAKE_CONFIG
from snowflake.connector.pandas_tools import write_pandas

def get_con():
    con = sc.connect(
        account=SNOWFLAKE_CONFIG["account"],
        user=SNOWFLAKE_CONFIG["user"],
        password=SNOWFLAKE_CONFIG["password"],
        warehouse=SNOWFLAKE_CONFIG["warehouse"],
        database=SNOWFLAKE_CONFIG["database"],
        schema=SNOWFLAKE_CONFIG["schema"]
    )
    
    print("Snowflake Conn Started")
    return con

def close_con(con):
    con.close()
    return print("Snowflake Conn Closed")

def create_schema(con):
    cur = con.cursor()
    cur.execute("CREATE SCHEMA IF NOT EXISTS RAW")
    cur.close()

def load_products(data,con):
    all_reviews = []

    for product in data:
        for review in product["reviews"]:
            review["product_id"]=product["id"]
            all_reviews.append(review)
        del product["reviews"]
        product["tags"] = json.dumps(product["tags"])
        product["dimensions"] = json.dumps(product["dimensions"])
        product["images"] = json.dumps(product["images"])
        product["meta"] = json.dumps(product["meta"])

    df_products = pd.DataFrame(data)
    df_reviews = pd.DataFrame(all_reviews)

    df_products.columns = df_products.columns.str.upper()
    df_reviews.columns = df_reviews.columns.str.upper()
    
    write_pandas(con,df_products,table_name="PRODUCTS",schema="RAW",database="DUMMYJSON",auto_create_table=True, overwrite=True)
    write_pandas(con,df_reviews,table_name="PRODUCT_REVIEWS",schema="RAW",database="DUMMYJSON",auto_create_table=True, overwrite=True)

def load_categories(data,con):
    df_categories = pd.DataFrame(data)

    df_categories.columns = df_categories.columns.str.upper()

    write_pandas(con,df_categories,table_name="CATEGORIES",schema="RAW",database="DUMMYJSON",auto_create_table=True, overwrite=True)

def load_users(data,con):
    for user in data:
        user["address_city"] = user["address"]["city"]
        user["address_state"] = user["address"]["state"]
        user["address_country"] = user["address"]["country"]
        user["company"] = json.dumps(user["company"])
        user["hair"] = json.dumps(user["hair"])
        del user["address"]
        del user["bank"]
        del user["crypto"]
        del user["ssn"]
        del user["password"]
    df_users = pd.DataFrame(data)

    df_users.columns = df_users.columns.str.upper()

    write_pandas(con,df_users,table_name="USERS",schema="RAW",database="DUMMYJSON",auto_create_table=True, overwrite=True)

def load_carts(data,con):
    all_products = []

    for cart in data:
        for product in cart["products"]:
            product["cart_id"] = cart["id"]
            all_products.append(product)
        del cart["products"]
    df_carts = pd.DataFrame(data)
    df_product_in_carts = pd.DataFrame(all_products)

    df_carts.columns = df_carts.columns.str.upper()
    df_product_in_carts.columns = df_product_in_carts.columns.str.upper()

    write_pandas(con,df_carts,table_name="CARTS",schema="RAW",database="DUMMYJSON",auto_create_table=True, overwrite=True)
    write_pandas(con,df_product_in_carts,table_name="CART_ITEMS",schema="RAW",database="DUMMYJSON",auto_create_table=True, overwrite=True)