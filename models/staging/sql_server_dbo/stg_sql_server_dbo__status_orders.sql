{{
  config(
    materialized='view'
  )
}}
with 

src_promos as (

    select * from {{ ref('stg_sql_server_dbo_orders') }}

),

renamed_casted as (

    select distinct
        status_id,
        status,
        status_tipo,
        _fivetran_deleted,
        _fivetran_synced_utc

    from src_promos

)

select * from renamed_casted