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

    select
        address_id,
        zipcode,
        country,
        address,
        state,
        COALESCE(_fivetran_deleted,false) AS _fivetran_deleted,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_UTC

    from src_addresses )




select * from renamed_casted