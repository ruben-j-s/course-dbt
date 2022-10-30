## Week 3 Project

#### Part 1 - Conversion model

1. What is our overall conversion rate?

```sql
select
    count(distinct session_id)  as sessions,
    count(distinct order_id)    as orders,
    orders/sessions * 100       as conversion_rate
from fact_conversion;
```

2. What is our conversion rate by product?

```sql
select
    c.product_id,
    p.name                      as product_name,
    count(distinct session_id)  as sessions,
    count(distinct order_id)    as orders,
    orders/sessions * 100       as conversion_rate
from fact_conversion c
left join dim_products p ON c.product_id=p.product_id
group by c.product_id, p.name
```

#### Part 2 - Macros

Created macro event_type_counts.sql to aggregate the event types and slice them by an input field.

#### Part 3 - Hooks

Added a post hook on all marts models to apply grants to the role “reporting”

#### Part 4 - Packages

Installed dbt_utils and codegen packages and used the following:
- surrogate_key
- get_column_values
- group_by

#### Part 5 - Snapshots

1. Run the orders snapshot model using dbt snapshot and query it in snowflake to see how the data has changed since last week. 
```sql
select * 
from DEV_DB.DBT_RUBEN.ORDERS_SNAPSHOT
where dbt_updated_at > DATEADD(day, -7, current_date())
```
2. Which orders changed from week 2 to week 3? 
- 38c516e8-b23a-493a-8a5c-bf7b2b9ea995
- d1020671-7cdf-493c-b008-c48535415611
- aafb9fbd-56e1-4dcc-b6b2-a3fd91381bb6


