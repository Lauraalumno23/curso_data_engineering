
with 

src_order_items as (

    select * from {{ ref('stg_sql_server_dbo__order_items') }}


),

renamed_casted as (

    select
        order_items_id,
        order_id,
        product_id,
        quantity,
        _fivetran_deleted,
        _fivetran_synced_UTC

    from src_order_items

)

select * from renamed_casted