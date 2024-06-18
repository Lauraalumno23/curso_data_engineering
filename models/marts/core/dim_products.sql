with 

src_products as (

    select * from {{ ref('stg_sql_server_dbo__products') }}

),
renamed_casted as (
select
    p.product_id,
    p.price_euro,
    p.name,
    p.inventory,
    t.item_per_order,
    t.price_product,
    t.shipping_cost_by_item_euros,
    t.order_cost_by_item_euros,
    t.total_order_by_item_euros,
    t.price_per_order,        
    t.order_cost_and_shipping_by_item_euros,
    t.total_discount_by_item_euros,

from {{ ref('stg_sql_server_dbo__products') }} p
left join {{ ref('int_products_items_orders') }} t
on p.product_id = t.product_id

)
select * from renamed_casted