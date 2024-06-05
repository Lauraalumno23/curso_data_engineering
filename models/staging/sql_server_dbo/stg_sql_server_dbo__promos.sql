{{
  config(
    materialized='view'
  )
}}
with 

src_promos as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

renamed_casted as (

    select
        promo_id,
        discount,
        status,
        case when status = 'active' then 1
        else 0
        end as status_numero,
        _fivetran_deleted,
        _fivetran_synced

    from src_promos

)

select * from renamed_casted
