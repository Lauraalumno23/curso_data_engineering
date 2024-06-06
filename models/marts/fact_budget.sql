WITH src_budget AS (
    SELECT * 
    FROM {{ ref('stg_google_sheets__budget') }}
    ),

renamed_casted AS (
    SELECT
        _row
        , product_id
        , quantity
        , month
    FROM src_budget
    )

SELECT * FROM renamed_casted