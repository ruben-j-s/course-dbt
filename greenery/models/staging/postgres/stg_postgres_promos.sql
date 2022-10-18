{{
  config(
    materialized='view'
  )
}}

SELECT
    PROMO_ID,
    DISCOUNT as promo_discount,
    STATUS as promo_status
FROM
    {{ source('postgres', 'promos') }}