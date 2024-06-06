{{
  config(
    materialized='view'
  )
}}
with 

src_events as (

    select * from {{ ref('base_sql_server_dbo__events') }}

),

renamed_casted as (

    select distinct
        event_type_id,
        event_type,
        _fivetran_deleted,
        _fivetran_synced_UTC

    from src_events

)

select * from renamed_casted