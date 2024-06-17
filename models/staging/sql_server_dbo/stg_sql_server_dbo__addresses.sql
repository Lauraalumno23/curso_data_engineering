{{
  config(
    materialized='view'
  )
}}
with 

src_addresses as (

    select * from {{ ref('base_sql_server_dbo__addresses') }}

),

renamed_casted as (

    select
        address_id,
        zipcode::integer as zipcode,
        country,
        address,
        {{ dbt_utils.generate_surrogate_key(['state']) }} AS state_id,
        state,
        COALESCE(_fivetran_deleted,false) AS _fivetran_deleted,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_UTC

    from src_addresses )


select * from renamed_casted
