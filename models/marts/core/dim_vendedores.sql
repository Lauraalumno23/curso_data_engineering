with

    src_vendedores as (select * from {{ ref('stg_sql_server_dbo__vendedores') }}
    
    ),

    renamed_casted as (
    select
        v.vendedores_id,
        v.first_name,
        v.last_name,
        v.email,
        v.salary,
        v.address_id,
        v.address,
        v.country,
        t.item_per_order,
        t.total_products_sold

    from {{ ref('stg_sql_server_dbo__vendedores') }} v
    left join {{ ref('int_vendedores_orders') }} t
    on v.vendedores_id = t.vendedores_id
    )
select* from renamed_casted