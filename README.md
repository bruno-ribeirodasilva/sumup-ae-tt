# Sumup challenge


## Design

### Source Tables
- The project uses CSV files as the source data.
- Three source tables are provided:
    - `transactions.csv`: Contains transaction data.
    - `stores.csv`: Contains store information.
    - `devices.csv`: Contains device information.

### DWH
- The project assumes that you have a PostgreSQL database server running locally.

### Staging Models
- Staging models (`stg_sumup_transactions`, `stg_sumup_stores`, `stg_sumup_devices`) ingest data from source tables and perform basic data cleansing and transformation.

### Mart Models
- The `transactions_enriched` model joins transaction data with store and device information to create an enriched dataset.
- Additional mart models (`store_transactions_agg`, `device_transactions_agg`, `product_transactions_agg`) aggregate data for reporting more cost-efficient.

### Dimension Models
- Dimension models (`products`, `devices`, `stores`) are created for products, devices, and stores, providing additional context for reporting or analysis.

### Analytics Models
- Analytics models were created to answer specific business questions. These can be found in the `analyses` folder.
    - Top 10 stores per transacted amount
    - Top 10 products sold
        - For this case, we based in the SKU uniqueness, as the combination of SKU-name-category was found to not be unique (uniqueness test fails)
    - Average transacted amount per store typology and country
    - Percentage of transactions per device type
    - Average time for a store to perform its 5 first transactions

## Solution Implementation

- The source data comes in CSV files and is ingested thorough a python script into Postgres.
- We use Postgres as a DWH solution, mainly because of its ease of use and cost.
- The project uses dbt to define models and transformations, as well as documentation and testing.
- Data transformations are defined using SQL in dbt models.
- The `dbt_project.yml` file defines the project configuration, including connections to the database.
- The `profiles.yml` file contains database connection details.

## Project Data Model


## Project DAG

<p align="center">
  <img src="/assets/dag.png">
</p>
