WITH src_budget AS (
    SELECT budget_id,
        count(budget_id) as count_budget
    FROM {{ ref('stg_google_sheets__budget') }}
    group by budget_id
    ),

src_quantity AS (
    SELECT quantity,
        sum(quantity) as sum_quantity
    FROM {{ ref('stg_google_sheets__budget') }}
    group by quantity
    ),

budget AS (
    SELECT *
    FROM {{ ref('stg_google_sheets__budget') }}

    ),

date AS (
    SELECT *
    FROM {{ ref('stg_sql_server_dbo__date') }}

    )

SELECT
        b.budget_id,
        b.product_id,
        b.quantity,
        sb.count_budget,
        sq.sum_quantity,
        d.date_id,
        round((sq.sum_quantity/d.MONTH_OF_YEAR),2) as quantity_by_month,
        round((sq.sum_quantity/d.WEEK_OF_YEAR),2) as quantity_by_week,
        round((sq.sum_quantity/d.DAY_OF_MONTH),2) as quantity_by_day
        
FROM 
    budget b
LEFT JOIN src_budget sb
    ON b.budget_id = sb.budget_id
LEFT JOIN src_quantity sq
    ON b.quantity = sq.quantity
LEFT JOIN date d
    ON b.date = d.date_day