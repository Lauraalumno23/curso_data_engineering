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
        {{ dbt_utils.generate_surrogate_key(['id']) }} as vendedores_id,
        first_name,
        last_name,
        email,
        salary,
        address,
        country,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_UTC

    from source

)

select * from renamed
