## Week 2 Project

#### Part 1: Models

1. What is our repeat user rate?
Repeat rate = Users who purchased 2 or more times / users who purchased

Answer: user_repeat_rate = 79,8% 
```sql
with users_with_more_orders as (
    select 
        user_id, 
        count(distinct order_id) as total_orders
    from stg_postgres_orders 
    group by 1
    having count(distinct order_id) >=2
)
select 
    count(distinct o2.user_id) as rep_count, 
    count(distinct o.user_id) as user_order_count,
    rep_count / user_order_count * 100 as user_repeat_rate
from stg_postgres_orders o
left join users_with_more_orders o2 on o.user_id=o2.user_id 
```

2. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

Likely purchase again:
- User browsing product pages > recent product view events
- Positive review of previous purchases
- Long session duration

Likely not purchase again:
- No recent product view events
- Negative review of previous purchases

3. Explain the marts models you added. Why did you organize the models in the way you did?

Separate Core / Marketing / Product folders for each business line. Each with their own Intermediate folder for int models.
One yml file for all Core models, as well as 1 yml file for Marketing + Product models. One yml file for each individual model feels as too much.

#### Part 2: Tests

1. What assumptions are you making about each model? (i.e. why are you adding each test?)

Answer: That each staging model has a unique, not null primary key.

2. Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

Answer: I had to create a surrogate key in my fact_user_events model, in order to have a unique, non null primary key.


#### Part 3: Snapshots

 1. Which orders changed from week 1 to week 2? 

 ```sql
with changed_orders as (
select order_id
from DEV_DB.DBT_RUBEN.ORDERS_SNAPSHOT
where dbt_valid_to is not null
)
select s.order_id, MAX(s.dbt_updated_at),MAX(s.estimated_delivery_at) ,COUNT(*) as order_version_count
from DEV_DB.DBT_RUBEN.ORDERS_SNAPSHOT s
inner join changed_orders c ON s.order_id=c.order_id
group by 1
```
ORDER_ID
8385cfcd-2b3f-443a-a676-9756f7eb5404
e24985f3-2fb3-456e-a1aa-aaf88f490d70
5741e351-3124-4de7-9dff-01a448e7dfd4
914b8929-e04a-40f8-86ee-357f2be3a2a2
05202733-0e17-4726-97c2-0520c024ab85
939767ac-357a-4bec-91f8-a7b25edd46c9
