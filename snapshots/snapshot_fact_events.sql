{% snapshot fact_events_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='event_id',
      strategy='timestamp',
      updated_at='_fivetran_synced',
    )
}}

select * from {{ source('sql_server_dbo','events') }}

{% endsnapshot %}