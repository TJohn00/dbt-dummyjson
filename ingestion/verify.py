import snowflake.connector
from ingestion.snowflake_config import SNOWFLAKE_CONFIG

con = snowflake.connector.connect(
    account=SNOWFLAKE_CONFIG["account"],
    user=SNOWFLAKE_CONFIG["user"],
    password=SNOWFLAKE_CONFIG["password"],
    warehouse=SNOWFLAKE_CONFIG["warehouse"],
    database=SNOWFLAKE_CONFIG["database"],
    schema=SNOWFLAKE_CONFIG["schema"]
)

print("Connected to Snowflake!")
con.close()
print("Connection closed.")