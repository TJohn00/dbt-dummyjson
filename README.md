# DummyJSON dbt Project

## Overview
An end-to-end data pipeline that ingests data from the [DummyJSON REST API](https://dummyjson.com),
loads it into a local DuckDB warehouse, and transforms it through a modular dbt project 
with staging, intermediate, and mart layers — producing clean, analytics-ready tables.

## Architecture
DummyJSON API
↓
Python (requests)        — fetches products, users, carts, categories
↓
DuckDB (raw.)           — stores raw JSON as flat tables
↓
dbt Staging (stg_)      — cleans column names, casts data types, unnests arrays
↓
dbt Intermediate (int_) — joins, enriches, and applies business logic
↓
dbt Marts (mart_)       — final analytics-ready tables for reporting
## Tech Stack
- **Python** — API ingestion and data loading
- **DuckDB** — local analytical database
- **dbt (dbt-duckdb)** — data transformation and testing

## Setup & How to Run

### 1. Clone the repository
```bash
git clone https://github.com/YOURUSERNAME/dbt-dummyjson.git
cd dbt-dummyjson
```

### 2. Install dependencies
```bash
pip install dbt-duckdb duckdb requests pandas
```

### 3. Configure dbt profile
Create a `profiles.yml` file at `~/.dbt/profiles.yml`:
```yaml
dbt_project:
  outputs:
    dev:
      type: duckdb
      path: /absolute/path/to/DB/mydb.duckdb
      threads: 1
  target: dev
```

### 4. Run ingestion
```bash
python -m ingestion.run_ingestion
```

### 5. Run dbt
```bash
cd dbt_project
dbt run
dbt test
```

## Data Sources
All data is sourced from [DummyJSON](https://dummyjson.com) — a free public REST API.

| Endpoint | Description |
|---|---|
| `/products` | 194 products with pricing, stock, ratings |
| `/products/categories` | 28 product categories |
| `/users` | 208 users with demographics and location |
| `/carts` | 50 carts with line items |

## Models

| Layer | Count | Materialization |
|---|---|---|
| Staging | 6 | View |
| Intermediate | 6 | View |
| Marts | 9 | Table |
| **Total** | **21** | |

**77 dbt tests** enforced across all layers covering uniqueness, 
null checks, and referential integrity.

## Raw Tables
After ingestion, the following tables are created in DuckDB under the `raw` schema:
- `raw.products`
- `raw.product_reviews`
- `raw.categories`
- `raw.users`
- `raw.carts`
- `raw.product_in_carts`