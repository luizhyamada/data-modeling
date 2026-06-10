CREATE or replace TABLE  silver.air_cia (
    airline_id integer,
    company_name string,
    icao string,
    iata string,
    tax_id string,
    air_operations string,
    headquarters_address string,
    phone_number string,
    email string,
    operational_status string,
    operational_status_date date,
    operational_valid_until date,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
) USING DELTA;