SELECT *
FROM read_csv_auto('C:\Users\eier\Downloads/gold_fact_sales.csv')
LIMIT 10;


COPY (
    SELECT *
    FROM read_csv_auto('C:\Users\eier\Downloads/gold_fact_sales.csv')
) TO 'C:\Users\eier\Downloads/gold_fact_sales.parquet' (FORMAT PARQUET);


CREATE OR REPLACE VIEW gold_fact_sales AS
SELECT *
FROM read_parquet('C:\Users\eier\Downloads/gold_fact_sales.parquet');


----############## customers
SELECT *
FROM read_csv_auto('C:\Users\eier\Downloads/gold_dim_customers.csv')
LIMIT 10;


COPY (
    SELECT *
    FROM read_csv_auto('C:\Users\eier\Downloads/gold_dim_customers.csv')
) TO 'C:\Users\eier\Downloads/gold_dim_customers.parquet' (FORMAT PARQUET);


CREATE OR REPLACE VIEW gold_dim_customers AS
SELECT *
FROM read_parquet('C:\Users\eier\Downloads/gold_dim_customers.parquet');

------################ sellers 

COPY (
    SELECT *
    FROM read_csv_auto('C:\Users\eier\Downloads/gold_dim_sellers.csv')
) TO 'C:\Users\eier\Downloads/gold_dim_sellers.parquet' (FORMAT PARQUET);


CREATE OR REPLACE VIEW gold_dim_sellers AS
SELECT *
FROM read_parquet('C:\Users\eier\Downloads/gold_dim_sellers.parquet');


--------- product 

COPY (
    SELECT *
    FROM read_csv_auto('C:\Users\eier\Downloads/gold_dim_products.csv')
) TO 'C:\Users\eier\Downloads/gold_dim_products.parquet' (FORMAT PARQUET);


CREATE OR REPLACE VIEW gold_dim_products AS
SELECT *
FROM read_parquet('C:\Users\eier\Downloads/gold_dim_products.parquet');


--------- sales  

SELECT *
FROM read_csv_auto('C:/Users/eier/Downloads/gold_fact_sales_items.csv')
LIMIT 10;

CREATE OR REPLACE VIEW gold_fact_sales_items AS
SELECT *
FROM read_parquet('C:/Users/eier/Downloads/gold_fact_sales_items.parquet');


