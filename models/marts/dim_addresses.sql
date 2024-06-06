with src_addresses as (

    select * from {{ ref('stg_sql_server_dbo__addresses') }}

),

renamed_casted as (

    select
        address_id,
        zipcode,
        country,
        address,
        state_id

    from src_addresses )




select * from renamed_casted
