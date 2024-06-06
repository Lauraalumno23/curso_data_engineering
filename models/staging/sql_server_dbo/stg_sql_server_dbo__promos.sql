{{
  config(
    materialized='view'
  )
}}
with 

src_promos as (

    select * from {{ ref('base_sql_server_dbo__promos') }}

),

renamed_casted as (

    select
        promo_id,
        nombre_promo,
        discount,
        status_id,
        _fivetran_deleted,
        _fivetran_synced

    from src_promos

)

select * from renamed_casted
