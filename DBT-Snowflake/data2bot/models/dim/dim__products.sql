WITH stg_products AS (
SELECT * FROM {{ ref('stg__products') }}
)
SELECT *
FROM stg__products