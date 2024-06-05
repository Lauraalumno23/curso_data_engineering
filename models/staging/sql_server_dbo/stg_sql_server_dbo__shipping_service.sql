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

    select distinct 
        shipping_service_id,
        shipping_service,
        _fivetran_deleted,
        _fivetran_synced_UTC
    from src_orders
)

select * from renamed_casted
