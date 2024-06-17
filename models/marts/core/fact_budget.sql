WITH src_budget AS (
    SELECT * 
    FROM {{ ref('stg_google_sheets__budget') }}
    ),

renamed_casted AS (
    SELECT
        budget_id,
        _row,
        product_id,
        quantity,
        date,
        date_load
    FROM src_budget
    )

SELECT * FROM renamed_casted