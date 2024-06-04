{{
  config(
    materialized='view'
  )
}}
with 

src_addresses as (

    select * from {{ source('sql_server_dbo', 'addresses') }}

),

renamed_casted as (

    select distinct
        md5(state) as state_id,
        state
    from src_addresses )

select * from renamed_casted