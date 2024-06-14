{{
  config(
    materialized='view'
  )
}}
with 

source as (

    select * from {{ source('sql_server_dbo', 'vendedores') }}

),

renamed as (

    select
        id,
        first_name,
        last_name,
        email,
        salary,
        address,
        country,
        _fivetran_synced

    from source

)

select * from renamed