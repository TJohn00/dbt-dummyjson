import requests as r
from common_func import *

def fetch_products():
    return fetch_function("https://dummyjson.com/products","products")

def fetch_categories():
    req = r.get(f"https://dummyjson.com/products/categories")
    return req.json()

def fetch_users():
    return fetch_function("https://dummyjson.com/users","users")

def fetch_carts():
    return fetch_function("https://dummyjson.com/carts","carts")