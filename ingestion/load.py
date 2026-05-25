import duckdb as ddb
import json
import pandas as pd

def get_con():
    con = ddb.connect("DB/mydb.duckdb")
    print("DuckDB Conn Started")
    return con

def close_con(con):
    con.close()
    return print("DuckDB Conn Closed")

def create_schema(con):
    con.execute("CREATE SCHEMA IF NOT EXISTS raw")

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
    con.execute("CREATE OR REPLACE TABLE raw.products as SELECT * FROM df_products")
    con.execute("CREATE OR REPLACE TABLE raw.product_reviews as SELECT * FROM df_reviews")


def load_categories(data,con):
    df_categories = pd.DataFrame(data)
    con.execute("CREATE OR REPLACE TABLE raw.categories as SELECT * FROM df_categories")


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
    con.execute("CREATE OR REPLACE TABLE raw.users as SELECT * FROM df_users")


def load_carts(data,con):
    all_products = []

    for cart in data:
        for product in cart["products"]:
            product["cart_id"] = cart["id"]
            all_products.append(product)
        del cart["products"]
    df_carts = pd.DataFrame(data)
    df_product_in_carts = pd.DataFrame(all_products)
    con.execute("CREATE OR REPLACE TABLE raw.carts as SELECT * FROM df_carts")
    con.execute("CREATE OR REPLACE TABLE raw.cart_items as SELECT * FROM df_product_in_carts")
