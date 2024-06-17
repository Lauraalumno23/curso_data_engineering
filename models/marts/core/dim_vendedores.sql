
with 

source as (

    select * from {{ ref('stg_sql_server_dbo__vendedores') }}

),

renamed as (

    select
        vendedores_id,
        first_name,
        last_name,
        email,
        salary,
        address_id,
        address,
        country,
        _fivetran_synced_UTC

    from source

)

select * from renamed