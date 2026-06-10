CREATE TABLE IF NOT EXISTS bronze.air_cia (
    company_name string,
    icao_iata_code string,
    tax_id string,
    air_operations string,
    headquarters_address string,
    phone_number string,
    email string,
    operational_status string,
    operational_status_date date,
    operational_valid_until date,
    _source_file STRING,
    _ingestion_date DATE,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
) USING DELTA;