with src_products as (

    select * from {{ source('sql_server_dbo', 'products') }}

),

renamed_casted as (

    select
        product_id,
        price_euro,
        name,
        inventory,
        _fivetran_deleted,
        _fivetran_synced_UTC

    from src_products

)

select * from renamed_casted
