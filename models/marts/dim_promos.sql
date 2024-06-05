with src_promos as (

    select * from {{ ref('stg_sql_server_dbo__promos') }}

),

renamed_casted as (

    select
        promo_id,
        discount,
        status,
        status_numero,
        _fivetran_deleted,
        _fivetran_synced

    from src_promos

)

select * from renamed_casted