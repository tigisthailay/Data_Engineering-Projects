{{
config(
materialized = 'view',
)
}}
WITH src_products AS (
SELECT * FROM {{ ref('src__products') }}
)
SELECT
PRODUCT_ID::NUMBER AS PRODUCT_ID,
PRODUCT_NAME
FROM src_products