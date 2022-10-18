{{
  config(
    materialized='view'
  )
}}

SELECT
    EVENT_ID,
    SESSION_ID,
    USER_ID,
    PAGE_URL,
    CREATED_AT as event_at,
    EVENT_TYPE,
    ORDER_ID,
    PRODUCT_ID
FROM
    {{ source('postgres', 'events') }}