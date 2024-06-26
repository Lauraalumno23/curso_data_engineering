{{
  config(
    materialized='view'
  )
}}
with 

src_addresses as (

    select * from {{ ref('stg_sql_server_dbo__addresses') }}
    

),

renamed_casted as (

    select distinct
        state_id,
        state,
        _fivetran_deleted,
        _fivetran_synced_UTC
    from src_addresses )

select * from renamed_casted