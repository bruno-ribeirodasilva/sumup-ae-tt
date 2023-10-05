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

except psycopg2.Error as e:
    print(f"Error creating database '{db_name}':")
    print(e)

finally:
    if conn:
        conn.close()
