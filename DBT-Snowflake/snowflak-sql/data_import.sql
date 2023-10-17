USE WAREHOUSE SUPERMARKET_WH;
USE DATABASE SUPERMARKET;
USE SCHEMA RAW;


CREATE TABLE IF NOT EXISTS RAW_SALES (
  invoice_id STRING,
  branch STRING,
  city INTEGER,
  customer STRING,
  gender STRING,
  product_line INTEGER,
  price NUMBER,
  quantity INTEGER,
  tax NUMBER,
  total NUMBER,
  date STRING,
  time STRING,
  payment STRING,
  cogs NUMBER,
  gross_income NUMBER,
  rating INTEGER
);

CREATE TABLE IF NOT EXISTS RAW_PRODUCTS (
  product_id STRING,
  product_name STRING
);


COPY INTO RAW_SALES (
  invoice_id, branch, city, customer,
  gender, product_line, price, quantity,
  tax, total, date, time, payment, cogs,
  gross_income, rating)
  from s3://d2b-academy-dbt-public/supermarket_sales.csv
  FILE_FORMAT = (type = 'CSV' skip_header = 1);

COPY INTO RAW_PRODUCTS(
  product_id, product_name)
  from s3://d2b-academy-dbt-public/product.csv
  FILE_FORMAT = (type = 'CSV' skip_header = 1);
