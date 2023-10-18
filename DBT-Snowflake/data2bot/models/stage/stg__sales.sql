{{
config(
materialized = 'view',
)
}}
WITH src_sales AS (
SELECT * FROM {{ ref('src__sales') }}
)
SELECT
INVOICE_ID,
BRANCH,
CITY,
CUSTOMER AS CUSTOMER_TYPE,
GENDER,
CASE
WHEN LENGTH(DATE) = 8 THEN TO_DATE(CONCAT(SUBSTR(DATE,1, 6), 20, RIGHT(DATE,
2)))
WHEN LENGTH(DATE) > 8 THEN TO_DATE(DATE)
END AS SALES_DATE,
TIME AS SALES_TIME,
PRODUCT_LINE AS PRODUCT_ID,
PAYMENT AS PAYMENT_METHOD,
PRICE,
QUANTITY,
TOTAL,
TAX,
COGS AS COST_OF_SALES,
RATING AS CUSTOMER_RATING
FROM src_sales