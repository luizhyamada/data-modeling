create or replace table gold.airports as 
select 
    airport_id,
    name,
    city,
    country,
    icao,
    created_at,
    updated_at
from 
    silver.airports;