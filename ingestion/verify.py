import duckdb
con = duckdb.connect(r"C:\Users\Thomas\PythonProjects\dbt_dummyjson\DB\mydb.duckdb")
print("categories",con.execute("DESCRIBE raw.categories").df())
print("users",con.execute("DESCRIBE raw.users").df())
print("carts",con.execute("DESCRIBE raw.carts").df())
print("cart_items",con.execute("DESCRIBE raw.cart_items").df())