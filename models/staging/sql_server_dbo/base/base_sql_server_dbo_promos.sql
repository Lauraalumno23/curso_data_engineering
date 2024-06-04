{{
  config(
    materialized='view'
  )
}}
with 

src_promos as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

src_promos_con_fila_nueva AS (

    SELECT * FROM src_promos
    union all
    select 
        'unknown' AS promo_id,       
        0 as discount,
        'inactive' as status,       
        null as _fivetran_deleted,
        current_date as _fivetran_synced
    
),
renamed_casted as (
    select 
        distinct md5(promo_id) as promo_id_hash,
        promo_id as promo_name,
        discount as discount_euros,
        case when status = 'active' then 1
            else 0
        end as status_id,
        COALESCE(_fivetran_deleted,false) AS _fivetran_deleted,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_UTC
        
    from src_promos_con_fila_nueva
)
select * from renamed_casted