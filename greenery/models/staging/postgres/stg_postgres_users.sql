{{
  config(
    materialized='view'
  )
}}

SELECT
    USER_ID,
    FIRST_NAME,
    LAST_NAME,
    FIRST_NAME || ' ' || LAST_NAME as full_name,
    EMAIL,
    PHONE_NUMBER,
    CREATED_AT,
    UPDATED_AT,
    ADDRESS_ID
FROM
    {{ source('postgres', 'users') }}