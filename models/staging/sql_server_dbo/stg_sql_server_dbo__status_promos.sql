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

    select distinct
        status_id,
        status,
        status_numero,
        _fivetran_deleted,
        _fivetran_synced

    from src_promos

)

select * from renamed_casted