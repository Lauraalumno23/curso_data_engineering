{{
  config(
    materialized='view'
  )
}}
with 

src_products as (

    select * from {{ ref('base_sql_server_dbo__products') }}
    

),

renamed_casted as (

    select
        product_id,
        price as price_euro,
        name,
        inventory,
        COALESCE(_fivetran_deleted,false) AS _fivetran_deleted,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_UTC

    from src_products

)

select * from renamed_casted
