{{
  config(
    materialized='view'
  )
}}

SELECT
    ORDER_ID,
    USER_ID,
    PROMO_ID,
    ADDRESS_ID,
    CREATED_AT,
    ORDER_COST,
    SHIPPING_COST,
    ORDER_TOTAL as total_cost,
    TRACKING_ID,
    SHIPPING_SERVICE as carrier,
    ESTIMATED_DELIVERY_AT,
    DELIVERED_AT,
    STATUS AS order_status
FROM
    {{ source('postgres', 'orders') }}