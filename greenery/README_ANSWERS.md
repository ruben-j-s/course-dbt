
### How many users do we have?

Answer: 130

```sql
SELECT COUNT(*) FROM DBT_RUBEN.STG_POSTGRES_USERS
```

### On average, how many orders do we receive per hour?

Answer: 7.7 orders / hour

```sql
WITH C AS (
    SELECT 
    MIN(CREATED_AT) AS MIN_ORDER_DT,
    MAX(CREATED_AT) AS MAX_ORDER_DT,
    COUNT(DISTINCT order_id) AS ORDER_COUNT
    FROM DBT_RUBEN.STG_POSTGRES_ORDERS
)
SELECT ORDER_COUNT/datediff(HOUR, MIN_ORDER_DT, MAX_ORDER_DT) AS AVG_ORDER_HOUR
FROM C
```

### On average, how long does an order take from being placed to being delivered?

Answer: 93.4 Hours or 3.9 days

```sql
SELECT avg(datediff(DAY, CREATED_AT, DELIVERED_AT))
FROM DBT_RUBEN.STG_POSTGRES_ORDERS
```

### How many users have only made one purchase? Two purchases? Three+ purchases?
### Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

Answer:
ORDER_COUNT	USER_COUNT
1           25
2           28
3+	        71

```sql
WITH P1 AS (
SELECT 
    user_id, COUNT(DISTINCT ORDER_ID) ORDER_COUNT
FROM DBT_RUBEN.STG_POSTGRES_ORDERS
GROUP BY user_id
HAVING COUNT(DISTINCT ORDER_ID) = 1
),
P2 AS (
SELECT 
    user_id, COUNT(DISTINCT ORDER_ID) ORDER_COUNT
FROM DBT_RUBEN.STG_POSTGRES_ORDERS
GROUP BY user_id
HAVING COUNT(DISTINCT ORDER_ID) = 2
),
P3 AS (
SELECT 
    user_id, COUNT(DISTINCT ORDER_ID) ORDER_COUNT
FROM DBT_RUBEN.STG_POSTGRES_ORDERS
GROUP BY user_id
HAVING COUNT(DISTINCT ORDER_ID) >= 3
)
SELECT '1' AS ORDER_COUNT, COUNT(DISTINCT USER_ID) AS USER_COUNT FROM P1
UNION ALL
SELECT '2' AS ORDER_COUNT, COUNT(DISTINCT USER_ID) AS USER_COUNT FROM P2
UNION ALL
SELECT '3+' AS ORDER_COUNT, COUNT(DISTINCT USER_ID) AS USER_COUNT FROM P3
```

### On average, how many unique sessions do we have per hour?

Answer: 10.1 sessions / hour

```sql
WITH S AS (
    SELECT 
    MIN(CREATED_AT) AS MIN_EVENT_DT,
    MAX(CREATED_AT) AS MAX_EVENT_DT,
    COUNT(DISTINCT SESSION_ID) AS SESSION_COUNT
    FROM DBT_RUBEN.STG_POSTGRES_EVENTS
)
SELECT SESSION_COUNT/datediff(HOUR, MIN_EVENT_DT, MAX_EVENT_DT) AS AVG_SESSION_HOUR
FROM S
```