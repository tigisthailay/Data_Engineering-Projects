{{
config(
materialized = 'incremental',
unique_key = 'sales_id',
on_schema_change = 'fail',
)
}}
WITH stg_sales AS (
SELECT * FROM {{ ref('stg__sales') }}
)
SELECT
SALES_ID,
BRANCH,
CITY,
CUSTOMER_TYPE,
GENDER,
SALES_DATE,
SALES_TIME,
PRODUCT_ID,
PAYMENT_METHOD,
PRICE,
QUANTITY,
TOTAL,
(QUANTITY * PRICE) AS COST_OF_SALES,
CUSTOMER_RATING
FROM
stg_sales
{% if is_incremental() %}
WHERE SALES_DATE &gt;= coalesce((select max(SALES_DATE) from {{ this }}), '1900-01-
01')
{% endif %}