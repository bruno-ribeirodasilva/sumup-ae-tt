import psycopg2

# Database connection parameters - change according to your credentials
db_params = {
    "host": "localhost",
    "user": "brunodasilva",
    "password": None,
}

# Database name
db_name = "sumup"

# Create a database
try:
    conn = psycopg2.connect(**db_params)
    conn.autocommit = True
    cursor = conn.cursor()

    # Create the database
    cursor.execute(f"CREATE DATABASE {db_name}")

    print(f"Database '{db_name}' created successfully.")

    # Connect to the newly created database
    conn.close()
    db_params["database"] = db_name
    conn = psycopg2.connect(**db_params)
    conn.autocommit = True
    cursor = conn.cursor()

    # Create source tables using CSV files
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS public.transactions (
            id serial PRIMARY KEY,
            device_id integer,
            product_name varchar,
            product_sku varchar,
            category_name varchar,
            amount numeric,
            status varchar,
            card_number varchar,
            cvv integer,
            created_at text,
            happened_at text
        )
    """)

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS public.stores (
            id serial PRIMARY KEY,
            name varchar,
            address varchar,
            city varchar,
            country varchar,
            created_at text,
            typology varchar,
            customer_id integer
        )
    """)

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS public.devices (
            id serial PRIMARY KEY,
            type integer,
            store_id integer
        )
    """)

    print("Source tables created successfully.")

    # Load data from CSV files into source tables
    cursor.execute("""
        COPY public.transactions
        FROM '/Users/brunodasilva/sumup-ae-tt/scripts/raw_data/transactions.csv'
        CSV HEADER;
    """)

    cursor.execute("""
        COPY public.stores
        FROM '/Users/brunodasilva/sumup-ae-tt/scripts/raw_data/stores.csv'
        CSV HEADER;
    """)

    cursor.execute("""
        COPY public.devices
        FROM '/Users/brunodasilva/sumup-ae-tt/scripts/raw_data/devices.csv'
        CSV HEADER;
    """)

    print("CSV data loaded into source tables.")

except psycopg2.Error as e:
    print("Error creating tables or loading data:")
    print(e)

finally:
    if conn:
        conn.close()
