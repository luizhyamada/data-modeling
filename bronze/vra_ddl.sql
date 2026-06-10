create table bronze.vra(
    scheduled_arrival timestamp,
    actual_arrival timestamp,
    authorization_code string,
    justification_code string,
    route_type_code string,
    destination_airport_icao string,
    origin_airport_icao string,
    airline_icao_code string,
    flight_number string,
    scheduled_departure timestamp,
    actual_departure timestamp,
    flight_status string,
    _source_file STRING,
    _ingestion_date DATE,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP
) USING DELTA;