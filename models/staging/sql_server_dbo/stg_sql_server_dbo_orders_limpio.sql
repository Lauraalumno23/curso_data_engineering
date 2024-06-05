{{
  config(
    materialized='view'
  )
}}
with 

src_orders as (

    select * from {{ ref('stg_sql_server_dbo__orders') }}

),

renamed_casted as (

    select
        order_id,
        md5(COALESCE(NULLIF(shipping_service,''),'unknown')) AS shipping_service_id,
        address_id,
        convert_timezone('UTC', created_at) as created_at_UTC,
        COALESCE(NULLIF(promo_id,''),'unknown') AS promo_id,
        order_cost as order_cost_euros,
        user_id,
        order_total as order_total_euros,
        COALESCE(NULLIF(tracking_id,''),'unknown') AS tracking_id,
        status,
        COALESCE(_fivetran_deleted,false) AS _fivetran_deleted,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_UTC

    from src_orders

)

select * from renamed_casted
