
with 

src_promos as (

    select * from {{ ref('stg_sql_server_dbo__promos') }}

),

renamed_casted as (
    select 
        promo_id,
        promo_name,
        discount_euros,
        status_id,
        _fivetran_deleted,
        _fivetran_synced_UTC
        
    from src_promos
)
select * from renamed_casted