WITH scr_date AS (
   select* from {{ ref('stg_sql_server_dbo__date') }} 

),
renamed_casted as (

    SELECT
        DATE_ID,
        DATE_DAY,
        DAY_OF_WEEK,
        DAY_OF_WEEK_NAME,
        DAY_OF_MONTH,
        DAY_OF_YEAR,
        WEEK_OF_YEAR,
        MONTH_NAME,
        MONTH_OF_YEAR,
        QUARTER_OF_YEAR,
        YEAR_NUMBER
    FROM scr_date
)
select * from renamed_casted
