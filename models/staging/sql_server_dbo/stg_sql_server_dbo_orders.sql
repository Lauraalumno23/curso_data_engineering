{{
  config(
    materialized='view'
  )
}}
with 

src_orders as (

    select * from {{ ref('base_sql_server_dbo__orders') }}

),

renamed_casted as (

    select
        order_id,
        shipping_service_id,
        address_id,
        created_at_UTC,
        promo_id,
        order_cost_euros,
        user_id,
        order_total_euros,
        tracking_id,
        status_id,
        _fivetran_deleted,
        _fivetran_synced_UTC

    from src_orders

)

select * from renamed_casted
