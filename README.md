# DummyJSON dbt Project

## Overview
An end-to-end data pipeline that ingests data from the [DummyJSON REST API](https://dummyjson.com),
loads it into Snowflake, and transforms it through a modular dbt project with staging, 
intermediate, and mart layers — producing clean, analytics-ready tables backed by 77 dbt tests.

## Architecture
DummyJSON API
↓
Python (requests)           — fetches products, users, carts, categories
↓
Snowflake (RAW.)           — stores raw JSON as flat tables
↓
dbt Staging (stg_)         — cleans column names, casts data types
↓
dbt Intermediate (int_)    — joins, enriches, and applies business logic
↓
dbt Marts (mart_)          — final analytics-ready tables for reporting
## Tech Stack
- **Python** — API ingestion and data loading
- **Snowflake** — cloud data warehouse
- **dbt (dbt-snowflake)** — data transformation and testing
- **DuckDB** — local development target

## Setup & How to Run

### 1. Clone the repository
```bash
git clone https://github.com/YOURUSERNAME/dbt-dummyjson.git
cd dbt-dummyjson
```

### 2. Install dependencies
```bash
pip install dbt-snowflake dbt-duckdb snowflake-connector-python pandas requests
pip install "snowflake-connector-python[pandas]"
```

### 3. Configure Snowflake credentials
Create `ingestion/snowflake_config.py` (never commit this file):
```python
SNOWFLAKE_CONFIG = {
    "account": "your_account_identifier",
    "user": "your_username",
    "password": "your_password",
    "warehouse": "COMPUTE_WH",
    "database": "DUMMYJSON",
    "schema": "RAW"
}
```

### 4. Configure dbt profile
Create `~/.dbt/profiles.yml`:
```yaml
dbt_project:
  outputs:
    dev:
      type: duckdb
      path: /path/to/DB/mydb.duckdb
      threads: 1
    snowflake:
      type: snowflake
      account: your_account_identifier
      user: your_username
      password: your_password
      role: ACCOUNTADMIN
      warehouse: COMPUTE_WH
      database: DUMMYJSON
      schema: RAW
      threads: 4
  target: snowflake
```

### 5. Run ingestion
```bash
# Load data into Snowflake
python -m ingestion.snowflake_run_ingestion

# Or load into local DuckDB
python -m ingestion.run_ingestion
```

### 6. Run dbt
```bash
cd dbt_project

# Against Snowflake
dbt run --target snowflake
dbt test --target snowflake

# Against local DuckDB
dbt run
dbt test
```

## Data Sources
All data is sourced from [DummyJSON](https://dummyjson.com) — a free public REST API.

| Endpoint | Rows | Description |
|---|---|---|
| `/products` | 194 | Products with pricing, stock, ratings and reviews |
| `/products/categories` | 28 | Product category reference data |
| `/users` | 208 | Users with demographics and location |
| `/carts` | 50 | Carts with line items |

## Raw Tables
After ingestion the following tables are created under the `RAW` schema:

| Table | Description |
|---|---|
| `RAW.PRODUCTS` | One row per product |
| `RAW.PRODUCT_REVIEWS` | One row per review, with product_id |
| `RAW.CATEGORIES` | Product category reference |
| `RAW.USERS` | One row per user |
| `RAW.CARTS` | One row per cart |
| `RAW.CART_ITEMS` | One row per cart line item, with cart_id |

## Models

| Layer | Models | Materialization | Description |
|---|---|---|---|
| Staging | 6 | View | Clean, renamed, typed |
| Intermediate | 6 | View | Joined and enriched |
| Marts | 9 | Table | Analytics-ready |
| **Total** | **21** | | |

**77 dbt tests** enforced across all layers covering uniqueness, null checks, 
and referential integrity.

### Mart Models
| Model | Description |
|---|---|
| `mart_product_catalog` | Full product listing with enriched pricing |
| `mart_category_performance` | Avg price, rating and stock per category |
| `mart_low_stock_alerts` | Products with stock below threshold |
| `mart_top_rated_products` | Highest rated product per category |
| `mart_user_profile` | Clean user master table |
| `mart_user_demographics` | User breakdown by gender |
| `mart_sales_summary` | Total revenue, orders and average order value |
| `mart_customer_spend` | Lifetime spend per customer |
| `mart_revenue_by_category` | Revenue and items sold per category |

## Key Concepts Demonstrated
- Medallion architecture (Bronze → Silver → Gold)
- Star schema data modeling
- dbt source declarations and ref() dependencies
- Incremental separation of concerns across layers
- Data quality enforcement via dbt generic and singular tests
- Dual target support — local DuckDB for dev, Snowflake for prod