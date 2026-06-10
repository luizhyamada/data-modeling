insert into silver.airports
select
    airport_id,
    name,
    city,
    country,
    case when iata = "\\N" then null else iata end as iata,
    case when icao = "\\N" then null else icao end as icao,
    case when latitude = "\\N" then null else latitude end as latitude,
    case when longitude = "\\N" then null else longitude end as longitude,
    case when altitude = "\\N" then null else altitude end as altitude,
    case when timezone = "\\N" then null else timezone end as timezone,
    case when dst = "\\N" then null else dst end as dst,
    case when tz = "\\N" then null else tz end as tz,
    case when type = "\\N" then null else type end as type,
    created_at,
    updated_at
from
    bronze.airports
qualify row_number() over (
    partition by airport_id
    order by updated_at desc
) = 1