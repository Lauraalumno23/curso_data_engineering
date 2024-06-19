
{{
  config(
    materialized='view'
  )
}}

WITH src_budget AS (
    SELECT * 
    FROM {{ ref('base_sql_server_dbo__budget') }}
    
    ),

renamed_casted AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['_row']) }} AS budget_id,
        _row,
        product_id,
        quantity::integer as quantity,
        month as date,
        _fivetran_synced::date AS date_load
    FROM src_budget
    )

SELECT * FROM renamed_casted