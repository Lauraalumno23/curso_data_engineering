
with 

src_events_type as (

    select * from {{ ref('stg_sql_server_dbo__events_type') }}

),

renamed_casted as (

    select distinct
        event_type_id,
        event_type,
        _fivetran_deleted,
        _fivetran_synced_UTC

    from src_events_type

)

select * from renamed_casted