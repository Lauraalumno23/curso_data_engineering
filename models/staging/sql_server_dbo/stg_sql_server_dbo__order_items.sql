{{
  config(
    materialized='view'
  )
}}
with 

src_order_items as (

    select * from {{ source('sql_server_dbo', 'order_items') }}

),

renamed_casted as (

    select
        order_id,
        product_id,
        quantity,
        COALESCE(_fivetran_deleted,false) AS _fivetran_deleted,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_UTC

    from src_order_items

)

select * from renamed_casted
