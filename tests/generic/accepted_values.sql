{% test accepted_values(model, column_name, values) %}

with validation as (
    select
        {{ column_name }} as value
    from
        {{ model }}
)

select
    value
from
    validation
where
    value not in ({{ values | join(', ') }})

{% endtest %}