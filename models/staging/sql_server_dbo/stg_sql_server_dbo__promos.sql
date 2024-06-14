{{
  config(
    materialized='view'
  )
}}
with 

src_promos as (

    select * from {{ ref('base_sql_server_dbo__promos') }}

),

renamed_casted as (
    select 
        distinct {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promo_id_hash,
        promo_id as promo_name,
        discount as discount_euros,
        md5(status) as status_id,
        case when status = 'active' then 1
            else 0
        end as status_modo,
        status,
        COALESCE(_fivetran_deleted,false) AS _fivetran_deleted,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_UTC
        
    from src_promos
)
select * from renamed_casted