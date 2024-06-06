with 

src_fact_orders as (

    select * from {{ ref('int_fact_orders') }}

),

renamed_casted as (

    select
        ORDER_ID,
        SHIPPING_SERVICE_ID,
        ADDRESS_ID,
        CREATED_AT_UTC,
        PROMO_ID,
        ORDER_COST_EUROS,
        USER_ID,
        ORDER_TOTAL_EUROS,
        TRACKING_ID,
        STATUS_ID,
        PRODUCT_ID,
        QUANTITY,
        PRICE_EURO,
        product_name,
        INVENTORY,
        TOTAL_PRECIO_CANTIDAD

    from src_fact_orders

)

select * from renamed_casted
