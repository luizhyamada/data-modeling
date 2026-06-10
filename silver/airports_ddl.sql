CREATE TABLE IF NOT EXISTS silver.airports (
    airport_id  INT,
    name        STRING,
    city        STRING,
    country     STRING,
    iata        STRING,
    icao        STRING,
    latitude    DOUBLE,
    longitude   DOUBLE,
    altitude    INT,
    timezone    STRING,
    dst         STRING,
    tz          STRING,
    type        STRING,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
) USING DELTA;