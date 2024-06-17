{{
  config(
    materialized='incremental',
    unique_key='order_items_id'
  )
}}
with 

src_order_items as (

    select * from {{ ref('base_sql_server_dbo__order_items') }}

    {% if is_incremental() %}

	  where _fivetran_synced > (select max(_fivetran_synced_UTC) from {{ this }})

    {% endif %}

),

renamed_casted as (

    select
        {{ dbt_utils.generate_surrogate_key(['order_id','product_id']) }} as order_items_id,
        order_id,
        product_id,
        quantity::integer as quantity,
        COALESCE(_fivetran_deleted,false) AS _fivetran_deleted,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_UTC

    from src_order_items

)

select * from renamed_casted
