{{
  config(
    materialized='view'
  )
}}
with 

source as (

    select * from {{ ref('base_sql_server_dbo__vendedores') }}
    

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['vendedores']) }} as vendedores_id,
        first_name,
        last_name,
        email,
        salary,
        {{ dbt_utils.generate_surrogate_key(['address']) }} as address_id,
        address,
        country,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_UTC

    from source

)

select * from renamed
